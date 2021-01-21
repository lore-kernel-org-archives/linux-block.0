Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2704C433E6
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 07:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79281239FC
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 07:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbhAUHI1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 02:08:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48755 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726184AbhAUHAF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 02:00:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611212311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=emHJzt/tpM/CifkchPnYgg332Gv+DDb4XlZgvposon4=;
        b=K/vi5yTrqKyrpJw/PExacDtv+dMVPVJ17/kiwFuxPJi+ZnFIohJF6MgUXO4nTeSu0rOB7I
        60AFODVZyKaGbIxsvnYPuODgRqtKuM/7cL3NBlN7fVVjT0nL3z9M8ZyZKowFvDwy0BAac7
        BL6FIX3b2KhwBjcfpwSr2tSNLfsbXrw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-sHfsJtYlO46AIlJU6flruw-1; Thu, 21 Jan 2021 01:58:23 -0500
X-MC-Unique: sHfsJtYlO46AIlJU6flruw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64BD1107ACE4;
        Thu, 21 Jan 2021 06:58:22 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-167.pek2.redhat.com [10.72.13.167])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4ECC419C46;
        Thu, 21 Jan 2021 06:58:20 +0000 (UTC)
Subject: Re: [PATCH blktests] rdma: Use rdma link instead of
 /sys/class/infiniband/*/parent
To:     Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
References: <20210121035954.7245-1-bvanassche@acm.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <be50e09c-393d-2ee1-1128-1149baac0da2@redhat.com>
Date:   Thu, 21 Jan 2021 14:58:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210121035954.7245-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 1/21/21 11:59 AM, Bart Van Assche wrote:
> The approach of verifying whether or not an RDMA interface is associated
> with the rdma_rxe interface by looking up its parent device is deprecated
> and will be removed soon. Hence this patch that uses the rdma link command
> instead.
>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   common/multipath-over-rdma | 107 ++++++++++---------------------------
>   tests/srp/rc               |   9 +---
>   2 files changed, 28 insertions(+), 88 deletions(-)
>
> diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
> index 9d9d2b27af83..b85e31e7bce1 100644
> --- a/common/multipath-over-rdma
> +++ b/common/multipath-over-rdma
> @@ -76,41 +76,9 @@ is_number() {
>   	[ "$1" -eq "0$1" ] 2>/dev/null
>   }
>   
> -# Check whether a device is an RDMA device. An example argument:
> -# /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.0
> -is_rdma_device() {
> -	local d i inode1 inode2
> -
> -	inode1=$(stat -c %i "$1")
> -	# echo "inode1 = $inode1"
> -	for i in /sys/class/infiniband/*; do
> -		d=/sys/class/infiniband/"$(readlink "$i")"
> -		d=$(dirname "$(dirname "$d")")
> -		inode2=$(stat -c %i "$d")
> -		# echo "inode2 = $inode2"
> -		if [ "$inode1" = "$inode2" ]; then
> -			return
> -		fi
> -	done
> -	false
> -}
> -
>   # Lists RDMA capable network interface names, e.g. ib0 ib1.
>   rdma_network_interfaces() {
> -	(
> -		cd /sys/class/net &&
> -			for i in *; do
> -				[ -e "$i" ] || continue
> -				# Skip IPoIB (ARPHRD_INFINIBAND) network
> -				# interfaces.
> -				[ "$(<"$i"/type)" = 32 ] && continue
> -				[ -L "$i/device" ] || continue
> -				d=$(readlink "$i/device" 2>/dev/null)
> -				if [ -n "$d" ] && is_rdma_device "$i/$d"; then
> -					echo "$i"
> -				fi
> -			done
> -	)
> +	rdma link show | sed -n 's,^link[[:blank:]]*\([^/]*\)/.*,\1,p' | sort -u
We should list the network interface here(like eno1), rxe/siw interfaces 
will not work for function get_ipv4_addr

# rdma link
link eno1_rxe/1 state ACTIVE physical_state LINK_UP netdev eno1
link eno1_siw/1 state ACTIVE physical_state LINK_UP netdev eno1

#  rdma link show | sed -n 's,^link[[:blank:]]*\([^/]*\)/.*,\1,p' | sort -u
eno1_rxe
eno1_siw

                 for i in $(rdma_network_interfaces)
                 do
                         ipv4_addr=$(get_ipv4_addr "$i")
                         if [ -n "${ipv4_addr}" ]; then
                                 def_traddr=${ipv4_addr}
                         fi
                 done
>   }
>   
>   # Check whether any stacked block device holds block device $1. If so, echo
> @@ -411,47 +379,36 @@ all_primary_gids() {
>   	done
>   }
>   
> -# Check whether or not an rdma_rxe instance has been associated with network
> -# interface $1.
> -has_rdma_rxe() {
> -	local f
> -
> -	for f in /sys/class/infiniband/*/parent; do
> -		if [ -e "$f" ] && [ "$(<"$f")" = "$1" ]; then
> -			return 0
> -		fi
> -	done
> -
> -	return 1
> +# Check whether or not an rdma_rxe or siw instance has been associated with
> +# network interface $1.
> +has_soft_rdma() {
> +	rdma link | grep -q " netdev $1[[:blank:]]*\$"
>   }
>   
>   # Load the rdma_rxe or siw kernel module and associate it with all network
>   # interfaces.
>   start_soft_rdma() {
> +	local type
> +
>   	{
>   	if [ -n "$use_siw" ]; then
>   		modprobe siw || return $?
> -		(
> -			cd /sys/class/net &&
> -				for i in *; do
> -					[ -e "$i" ] || continue
> -					[ -e "/sys/class/infiniband/${i}_siw" ] && continue
> -					rdma link add "${i}_siw" type siw netdev "$i" ||
> -						echo "Failed to bind the siw driver to $i"
> -				done
> -		)
> +		type=siw
>   	else
>   		modprobe rdma_rxe || return $?
> -		(
> -			cd /sys/class/net &&
> -				for i in *; do
> -					if [ -e "$i" ] && ! has_rdma_rxe "$i"; then
> -						echo "$i" > /sys/module/rdma_rxe/parameters/add ||
> -							echo "Failed to bind the rdma_rxe driver to $i"
> -					fi
> -				done
> -		)
> +		type=rxe
>   	fi
> +	(
> +		cd /sys/class/net &&
> +			for i in *; do
> +				[ -e "$i" ] || continue
> +				[ "$i" = "lo" ] && continue
> +				[ "$(<"$i/addr_len")" = 6 ] || continue
> +				has_soft_rdma "$i" && continue
> +				rdma link add "${i}_$type" type $type netdev "$i" ||
> +				echo "Failed to bind the $type driver to $i"
> +			done
> +	)
>   	} >>"$FULL"
>   }
>   
> @@ -459,27 +416,17 @@ start_soft_rdma() {
>   # unload the rdma_rxe kernel module.
>   stop_soft_rdma() {
>   	{
> -	(
> -		cd /sys/class/net &&
> -			for i in *; do
> -				if [ -e "$i" ] && has_rdma_rxe "$i"; then
> -					{ echo "$i" > /sys/module/rdma_rxe/parameters/remove; } \
> -						2>/dev/null
> -				fi
> -			done
> -	)
> +	rdma link |
> +		sed -n 's,^link[[:blank:]]*\([^/]*\)/.* netdev .*,\1,p' |
> +		while read -r i; do
> +		      echo "$i ..."
> +		      rdma link del "${i}" ||
> +			      echo "Failed to unbind siw/rxe from ${i}"
> +		done
>   	if ! unload_module rdma_rxe 10; then
>   		echo "Unloading rdma_rxe failed"
>   		return 1
>   	fi
> -	(
> -		cd /sys/class/net &&
> -			for i in *_siw; do
> -				[ -e "$i" ] || continue
> -				rdma link del "${i}" ||
> -					echo "Failed to unbind the siw driver from ${i%_siw}"
> -			done
> -	)
>   	if ! unload_module siw 10; then
>   		echo "Unloading siw failed"
>   		return 1
> diff --git a/tests/srp/rc b/tests/srp/rc
> index 1f665a28db66..b8ac9e27a2fd 100755
> --- a/tests/srp/rc
> +++ b/tests/srp/rc
> @@ -142,14 +142,7 @@ do_ib_cm_login() {
>   }
>   
>   rdma_dev_to_net_dev() {
> -	local b d rdma_dev=$1
> -
> -	b=/sys/class/infiniband/$rdma_dev/parent
> -	if [ -e "$b" ]; then
> -		echo "$(<"$b")"
> -	else
> -		echo "${rdma_dev%_siw}"
> -	fi
> +	rdma link show "$1/1" | sed 's/.* netdev //;s/[[:blank:]]*$//'
>   }
>   
>   # Tell the SRP initiator to log in to an SRP target using the RDMA/CM.
>

