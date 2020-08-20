Return-Path: <SRS0=Z7Y6=B6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587B1C433DF
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 04:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C012076E
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 04:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFmh3Qlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgHTEPv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Aug 2020 00:15:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20686 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726325AbgHTEPv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Aug 2020 00:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597896949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EA0Hb7FnoK/sz5zaAGcCCYXp+VZMZ1LDuCO70RkrXuo=;
        b=TFmh3QlpLt1IqKcg3GlzqL9IZFrakAQ2GpMUfQJcPzsrTf1DchGm++r5MsW1m/mZR7aBCp
        5ffihsz79D1OpHFvX9Er+nqrQ5laxdbmhQIWGS/GlTe2lC7fLAhbwZ1860mwWICf1ifQ++
        1/MPBMtBDd5rfTmlfYIkJpn6KIM1SQg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-gL8PvB9PNMKROSNGVC5ocA-1; Thu, 20 Aug 2020 00:15:46 -0400
X-MC-Unique: gL8PvB9PNMKROSNGVC5ocA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 248B581F024;
        Thu, 20 Aug 2020 04:15:45 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E85407A5DE;
        Thu, 20 Aug 2020 04:15:44 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id B20F360345;
        Thu, 20 Aug 2020 04:15:44 +0000 (UTC)
Date:   Thu, 20 Aug 2020 00:15:43 -0400 (EDT)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, sagi@grimberg.me, osandov@osandov.com
Message-ID: <1474153901.38161463.1597896943107.JavaMail.zimbra@redhat.com>
In-Reply-To: <ec3fab5b-0d26-a753-4b83-1f9dd94d4418@acm.org>
References: <20200819151601.18526-1-yi.zhang@redhat.com> <ec3fab5b-0d26-a753-4b83-1f9dd94d4418@acm.org>
Subject: Re: [PATCH blktests] common/multipath-over-rdma: fix warning
 ignored null byte in input
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.68.5.41, 10.4.195.13]
Thread-Topic: common/multipath-over-rdma: fix warning ignored null byte in input
Thread-Index: l8jonSliU14usEW2ds/USPzvs6zGMw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I've send the fix to linux-rdma, thanks.

Best Regards,
  Yi Zhang


----- Original Message -----
From: "Bart Van Assche" <bvanassche@acm.org>
To: "Yi Zhang" <yi.zhang@redhat.com>, linux-block@vger.kernel.org
Cc: sagi@grimberg.me, osandov@osandov.com
Sent: Thursday, August 20, 2020 12:51:12 AM
Subject: Re: [PATCH blktests] common/multipath-over-rdma: fix warning ignored null byte in input

On 2020-08-19 08:16, Yi Zhang wrote:
> [blktests]# nvme_trtype=rdma ./check nvme/004
> nvme/004 (test nvme and nvmet UUID NS descriptors)
>     runtime  1.238s  ...
> nvme/004 (test nvme and nvmet UUID NS descriptors)           [failed]ignored null byte in input
>     runtime  1.238s  ...  1.237s 410: warning: command substitution: ignored null byte in input
>     --- tests/nvme/004.out	2020-08-18 08:11:08.496809985 -0400
>     +++ /root/blktests/results/nodev/nvme/004.out.bad	2020-08-19 10:43:02.193885685 -0400
>     @@ -1,4 +1,5 @@
>      Running nvme/004
>     +common/multipath-over-rdma: line 409: warning: command substitution: ignored null byte in input
>      91fdba0d-f87b-4c25-b80f-db7be1418b9e
>      uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
>      NQN:blktests-subsystem-1 disconnected 1 controller(s)
> 
> manually to reproduce:
> Update one network interface with 15 chars:
> [blktests]# ip a s enp0s29u1u7u3c2
> 5: enp0s29u1u7u3c2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000
>     link/ether f0:d4:e2:e6:e1:e3 brd ff:ff:ff:ff:ff:ff
> [blktests]# modprobe rdma_rxe
> [blktests]# echo enp0s29u1u7u3c2 >/sys/module/rdma_rxe/parameters/add
> [blktests]# cat /sys/class/infiniband/rxe0/parent
> enp0s29u1u7u3c2[blktests]# f="/sys/class/infiniband/rxe0/parent"
> [blktests]# echo $(<"$f")
> -bash: warning: command substitution: ignored null byte in input
> enp0s29u1u7u3c2
> [blktests]# echo $(tr -d '\0' <"$f")
> enp0s29u1u7u3c2
> 
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  common/multipath-over-rdma | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
> index 355b169..86e7d86 100644
> --- a/common/multipath-over-rdma
> +++ b/common/multipath-over-rdma
> @@ -406,7 +406,7 @@ has_rdma_rxe() {
>  	local f
>  
>  	for f in /sys/class/infiniband/*/parent; do
> -		if [ -e "$f" ] && [ "$(<"$f")" = "$1" ]; then
> +		if [ -e "$f" ] && [ "$(tr -d '\0' <"$f")" = "$1" ]; then
>  			return 0
>  		fi
>  	done

sysfs reads should not yield '\0' bytes. Please fix the kernel code that yields
a string including '\0' when reading from sysfs.

Thanks,

Bart.


