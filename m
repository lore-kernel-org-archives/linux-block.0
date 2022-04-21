Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CECFC433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Apr 2022 08:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381854AbiDUIlq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Apr 2022 04:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239121AbiDUIlp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Apr 2022 04:41:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1250C3890
        for <linux-block@vger.kernel.org>; Thu, 21 Apr 2022 01:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650530336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZakaSjU0zwQrV7chgAy4v+dyrh94/T3y1bLqyYahVho=;
        b=QOrttZTNTdGjYaI8T+slut0nzAPeA4j349/smm8QFDWHNS5MEVps1jX088UArOxoK8qG3R
        17Xt3vzK0P0gbkHkOh3l5FeoqnyQhAqIXKoCR1jc88U0A7LOu7dG1inGeXj+jCyU6L9XhD
        RHiAOP2VrNXr+QrqohbMSaC7gRY1Byo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-AtxwZabsM2e8A6cnhFd7-g-1; Thu, 21 Apr 2022 04:38:52 -0400
X-MC-Unique: AtxwZabsM2e8A6cnhFd7-g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4ADC63C0F081;
        Thu, 21 Apr 2022 08:38:52 +0000 (UTC)
Received: from T590 (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C1EC1145BA55;
        Thu, 21 Apr 2022 08:38:47 +0000 (UTC)
Date:   Thu, 21 Apr 2022 16:38:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>,
        Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH blktests] block/002: delay debugfs directory check
Message-ID: <YmEYEYdO4SkNv0lc@T590>
References: <20220420045911.914393-1-shinichiro.kawasaki@wdc.com>
 <Yl/TjWYle8mOOwlO@T590>
 <20220420124213.5wc4umnjrlvu6zbi@shindev>
 <YmAhRtOnezJ2EwBl@T590>
 <20220421000247.lrwqgzolwpbeuwow@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421000247.lrwqgzolwpbeuwow@shindev>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 21, 2022 at 12:02:48AM +0000, Shinichiro Kawasaki wrote:
> On Apr 20, 2022 / 23:05, Ming Lei wrote:
> > On Wed, Apr 20, 2022 at 12:42:14PM +0000, Shinichiro Kawasaki wrote:
> > > On Apr 20, 2022 / 17:34, Ming Lei wrote:
> > > > On Wed, Apr 20, 2022 at 01:59:11PM +0900, Shin'ichiro Kawasaki wrote:
> > > > > The test case block/002 checks that device removal during blktrace run
> > > > > does not leak debugfs directory. The Linux kernel commit 0a9a25ca7843
> > > > > ("block: let blkcg_gq grab request queue's refcnt") triggered failure of
> > > > > the test case. The commit delayed queue release and debugfs directory
> > > > > removal then the test case checks directory existence too early. To
> > > > > avoid this false-positive failure, delay the directory existence check.
> > > > > 
> > > > > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > > > ---
> > > > >  tests/block/002 | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/tests/block/002 b/tests/block/002
> > > > > index 9b183e7..8061c91 100755
> > > > > --- a/tests/block/002
> > > > > +++ b/tests/block/002
> > > > > @@ -29,6 +29,7 @@ test() {
> > > > >  		echo "debugfs directory deleted with blktrace active"
> > > > >  	fi
> > > > >  	{ kill $!; wait; } >/dev/null 2>/dev/null
> > > > > +	sleep 0.5
> > > > >  	if [[ -d /sys/kernel/debug/block/${SCSI_DEBUG_DEVICES[0]} ]]; then
> > > > >  		echo "debugfs directory leaked"
> > > > >  	fi
> > > > 
> > > > Hello,
> > > > 
> > > > Jens has merged Yu Kuai's fix[1], so I think it won't be triggered now.
> > > > 
> > > > 
> > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-5.18&id=a87c29e1a85e64b28445bb1e80505230bf2e3b4b
> > > 
> > > Hi Ming, I applied the patch above on top of v5.18-rc3 and ran block/002.
> > > Unfortunately, it failed with a new symptom with KASAN use-after-free [2]. I
> > > ran block/002 with linux-block/block-5.18 branch tip with git hash a87c29e1a85e
> > > and got the same KASAN uaf. Reverting the patch from the linux-block/block-5.18
> > > branch, the KASAN uaf disappears (Still block/002 fails). Regarding block/002,
> > > it looks the patch made the failure symptom worse.
> > 
> > Hi Shinichiro,
> > 
> > Looks Yu Kuai's patch has other problem, can you drop that patch and
> > apply & test the attached patch?
> 
> Sure. With the patch, kernel message is clean. But I still observe the test case
> failure:
> 
> block/002 (remove a device while running blktrace)           [failed]
>     runtime  1.276s  ...  1.241s
>     --- tests/block/002.out     2022-04-14 11:29:04.760295898 +0900
>     +++ /home/shin/blktests/results/nodev/block/002.out.bad   2022-04-21 08:40:01.776511887 +0900
>     @@ -1,2 +1,3 @@
>      Running block/002
>     +debugfs directory deleted with blktrace active
>      Test complete

Hi Shinichiro,

Thanks for your test, and the above issue has been addressed in the
latest post:

https://lore.kernel.org/linux-block/20220421083431.2917311-1-ming.lei@redhat.com/T/#u


Thanks,
Ming

