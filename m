Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4748C4332B
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 11:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60CC2077D
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 11:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgCWLTw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 07:19:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:43616 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbgCWLTw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 07:19:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D4884AC90;
        Mon, 23 Mar 2020 11:19:50 +0000 (UTC)
Date:   Mon, 23 Mar 2020 12:19:50 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH blktests v3 3/4] Introduce the function
 _configure_null_blk()
Message-ID: <20200323111950.6xsolscppgtzwp7o@beryllium.lan>
References: <20200320222413.24386-1-bvanassche@acm.org>
 <20200320222413.24386-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320222413.24386-4-bvanassche@acm.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart,

On Fri, Mar 20, 2020 at 03:24:12PM -0700, Bart Van Assche wrote:
> Introduce a function for creating a null_blk device instance through
> configfs.
> 
> Suggested-by: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  common/multipath-over-rdma | 17 +++++------------
>  common/null_blk            | 14 ++++++++++++++
>  tests/block/029            | 16 ++--------------
>  3 files changed, 21 insertions(+), 26 deletions(-)
> 
> diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
> index a56e7a8269db..7e610a0ccbbb 100644
> --- a/common/multipath-over-rdma
> +++ b/common/multipath-over-rdma
> @@ -620,18 +620,11 @@ run_fio() {
>  configure_null_blk() {
>  	local i
>  
> -	(
> -		cd /sys/kernel/config/nullb || return $?
> -		for i in nullb0 nullb1; do (
> -			{ mkdir -p $i &&
> -				  cd $i &&
> -				  echo 0 > completion_nsec &&
> -				  echo 512 > blocksize &&
> -				  echo $((ramdisk_size>>20)) > size &&
> -				  echo 1 > memory_backed &&
> -				  echo 1 > power; } || exit $?
> -		) done
> -	)
> +	for i in nullb0 nullb1; do
> +		_configure_null_blk nullb$i completion_nsec=0 blocksize=512 \

I think this should be:

		_configure_null_blk $i completion_nsec=0 blocksize=512 \

Rest looks good, feel free do add my Reviewed-by when spinning a new version.

Thanks,
Daniel
