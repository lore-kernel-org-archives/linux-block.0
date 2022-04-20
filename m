Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05B2C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 09:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377247AbiDTJhF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Apr 2022 05:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241042AbiDTJhF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Apr 2022 05:37:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C00971BE9F
        for <linux-block@vger.kernel.org>; Wed, 20 Apr 2022 02:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650447258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hs7OL2dkLbEw7AwhXGNyM9z3bcCF7OwCahe4/o/d7hc=;
        b=D6DskJOuP0+pYGKlBmIut5THA9mzzasEnoZ0j7RRcOHiZahBm2Dsad35EWuiswQDYMvYqK
        WZrHME2OrGcCjps5JO6QU+gfzh07Wi7PGSC2B8gwgJTkAYXxiqtGsqgv7pJf+r6ldBaUmB
        IUisQSdoeg1pkDkEj+0DVGIynUqYw/w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-UERtp5eGMZ-6uUlclt7p5Q-1; Wed, 20 Apr 2022 05:34:15 -0400
X-MC-Unique: UERtp5eGMZ-6uUlclt7p5Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 403CC80005D;
        Wed, 20 Apr 2022 09:34:15 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 64394C44B1D;
        Wed, 20 Apr 2022 09:34:09 +0000 (UTC)
Date:   Wed, 20 Apr 2022 17:34:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>,
        Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH blktests] block/002: delay debugfs directory check
Message-ID: <Yl/TjWYle8mOOwlO@T590>
References: <20220420045911.914393-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420045911.914393-1-shinichiro.kawasaki@wdc.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 20, 2022 at 01:59:11PM +0900, Shin'ichiro Kawasaki wrote:
> The test case block/002 checks that device removal during blktrace run
> does not leak debugfs directory. The Linux kernel commit 0a9a25ca7843
> ("block: let blkcg_gq grab request queue's refcnt") triggered failure of
> the test case. The commit delayed queue release and debugfs directory
> removal then the test case checks directory existence too early. To
> avoid this false-positive failure, delay the directory existence check.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  tests/block/002 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/block/002 b/tests/block/002
> index 9b183e7..8061c91 100755
> --- a/tests/block/002
> +++ b/tests/block/002
> @@ -29,6 +29,7 @@ test() {
>  		echo "debugfs directory deleted with blktrace active"
>  	fi
>  	{ kill $!; wait; } >/dev/null 2>/dev/null
> +	sleep 0.5
>  	if [[ -d /sys/kernel/debug/block/${SCSI_DEBUG_DEVICES[0]} ]]; then
>  		echo "debugfs directory leaked"
>  	fi

Hello,

Jens has merged Yu Kuai's fix[1], so I think it won't be triggered now.


[1] https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-5.18&id=a87c29e1a85e64b28445bb1e80505230bf2e3b4b


Thanks,
Ming

