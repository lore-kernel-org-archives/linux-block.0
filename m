Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CAEC61DA4
	for <linux-block@archiver.kernel.org>; Sat, 18 Mar 2023 17:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCRRCQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Mar 2023 13:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCRRCP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Mar 2023 13:02:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38134234FC
        for <linux-block@vger.kernel.org>; Sat, 18 Mar 2023 10:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679158889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rg1yIqjO+fto+uya0q5Q73Zkr3fJVlR6YmEjgynQcZI=;
        b=g0LiZT/BQr5qVhDw7q5ORs1yMNqROU17samyNPS8/mirjFDFU25NujlkhoapRCLa4rcWVc
        89YxvWnZ06elRq9JuAzLQgsZqo35+LXQYsYRcF3a2qUgSUS7lHvJNePC4NXzBKYMJZPXKf
        0GVqlfs0bHp6Gq/KZ77xv3KdJV8gO6g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-seccua7EObiP9nNYJZMU5Q-1; Sat, 18 Mar 2023 13:01:26 -0400
X-MC-Unique: seccua7EObiP9nNYJZMU5Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D5FA858F09;
        Sat, 18 Mar 2023 17:01:25 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E66D43FBE;
        Sat, 18 Mar 2023 17:01:19 +0000 (UTC)
Date:   Sun, 19 Mar 2023 01:01:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Pavel Begunkov <asml.silence@gmail.com>, ming.lei@redhat.com
Subject: Re: [PATCH V3 00/16] io_uring/ublk: add IORING_OP_FUSED_CMD
Message-ID: <ZBXuW+hhVUVW/X0Q@ovpn-8-18.pek2.redhat.com>
References: <20230314125727.1731233-1-ming.lei@redhat.com>
 <b3fc9991-4c53-9218-a8cc-5b4dd3952108@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3fc9991-4c53-9218-a8cc-5b4dd3952108@kernel.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 18, 2023 at 10:09:52AM -0600, Jens Axboe wrote:
> On 3/14/23 6:57?AM, Ming Lei wrote:
> > Basically userspace can specify any sub-buffer of the ublk block request
> > buffer from the fused command just by setting 'offset/len'
> > in the slave SQE for running slave OP. This way is flexible to implement
> > io mapping: mirror, stripped, ...
> > 
> > The 3th & 4th patches enable fused slave support for the following OPs:
> > 
> > 	OP_READ/OP_WRITE
> > 	OP_SEND/OP_RECV/OP_SEND_ZC
> > 
> > The other ublk patches cleans ublk driver and implement fused command
> > for supporting zero copy.
> > 
> > Follows userspace code:
> > 
> > https://github.com/ming1/ubdsrv/tree/fused-cmd-zc-v2
> 
> Ran some quick testing here with qcow2. This is just done on my laptop
> in kvm, so take them with a grain of salt, results may be better
> elsewhere.
> 
> Basline:
> 
> 64k reads       98-100K IOPS    6-6.1GB/sec     (ublk 100%, io_uring 9%)
> 4k reads        670-680K IOPS   2.6GB/sec       (ublk 65%, io_uring 44%)
> 
> and with zerocopy enabled:
> 
> 64k reads       184K IOPS       11.5GB/sec      (ublk 91%, io_uring 12%)
> 4k reads        730K IOPS       2.8GB/sec       (ublk 73%, io_uring 48%)

There are other ways to observe the boost:

1) loop over file in tmpfs
- 1~2X in my test

2) nbd with local nbd server(nbdkit memory )
- less than 1X in my test

3) null
- which won't call into fused command, but can evaluate page copy cost
- 5+X in my test

> 
> and with zerocopy and using SINGLE_ISSUER|COOP_TASKRUN for the ring:
> 
> 64k reads       205K IOPS       12.8GB/sec      (ublk 91%, io_uring 12%)
> 4k reads        730K IOPS       2.8GB/sec       (ublk 66%, io_uring 42%)

Looks SINGLE_ISSUER|COOP_TASKRUN can get ~10% improvement, will look it.


Thanks,
Ming

