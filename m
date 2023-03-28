Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E4FC76195
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 01:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjC1BgJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 21:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC1BgI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 21:36:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B3B1BF0
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 18:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679967320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z/Lu4hvYujwOnJPvUPGyeNPV9KRZBeHZntNLTuypEck=;
        b=GbDLEOxdtGxuWlDp0C4RYlY/emEVphawFozz8Yy+h8kbHNY4RIxakDmQ6U1VTFcmogHQ7A
        jhL0wKaLztWTuANn293nAAWw/ehIUWALkZ1n5glMaHYQYToYcbWuAGj94+2S0yNwuw6Hyb
        05xM71U67pUn63J7uvcbsGUejIlRn00=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-hxmlryEPOm6Xasr0nnst2A-1; Mon, 27 Mar 2023 21:35:15 -0400
X-MC-Unique: hxmlryEPOm6Xasr0nnst2A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAEBE1C05138;
        Tue, 28 Mar 2023 01:35:14 +0000 (UTC)
Received: from ovpn-8-20.pek2.redhat.com (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 12AA7492C3E;
        Tue, 28 Mar 2023 01:35:06 +0000 (UTC)
Date:   Tue, 28 Mar 2023 09:35:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dan Williams <dan.j.williams@intel.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, ming.lei@redhat.com
Subject: Re: [PATCH V4 00/17] io_uring/ublk: add IORING_OP_FUSED_CMD
Message-ID: <ZCJERSOkzIo+SIm7@ovpn-8-20.pek2.redhat.com>
References: <20230324135808.855245-1-ming.lei@redhat.com>
 <642236912a229_29cc2942c@dwillia2-xfh.jf.intel.com.notmuch>
 <ZCJABlFshb0UmTMv@ovpn-8-20.pek2.redhat.com>
 <11651593-79d3-b21a-6441-63e1de5b39aa@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11651593-79d3-b21a-6441-63e1de5b39aa@kernel.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 27, 2023 at 07:29:36PM -0600, Jens Axboe wrote:
> On 3/27/23 7:16 PM, Ming Lei wrote:
> > Hi Dan,
> > 
> > On Mon, Mar 27, 2023 at 05:36:33PM -0700, Dan Williams wrote:
> >> Ming Lei wrote:
> >>> Hello Jens,
> >>>
> >>> Add IORING_OP_FUSED_CMD, it is one special URING_CMD, which has to
> >>> be SQE128. The 1st SQE(master) is one 64byte URING_CMD, and the 2nd
> >>> 64byte SQE(slave) is another normal 64byte OP. For any OP which needs
> >>> to support slave OP, io_issue_defs[op].fused_slave needs to be set as 1,
> >>> and its ->issue() can retrieve/import buffer from master request's
> >>> fused_cmd_kbuf. The slave OP is actually submitted from kernel, part of
> >>> this idea is from Xiaoguang's ublk ebpf patchset, but this patchset
> >>> submits slave OP just like normal OP issued from userspace, that said,
> >>> SQE order is kept, and batching handling is done too.
> >>
> >> Hi Ming,
> >>
> >> io_uring and ublk are starting to be more on my radar these days. I
> >> wanted to take a look at this series, but could not get past the
> >> distracting "master"/"slave" terminology in this lead-in paragraph let
> >> alone start looking at patches.
> >>
> >> Frankly, the description sounds more like "head"/"tail", or even
> >> "fuse0"/"fuse1" because, for example, who is to say you might not have
> > 
> > The term "master/slave" is from patches.
> > 
> > The master command not only provides buffer for slave request, but also requires
> > slave request for serving master command, and master command is always completed
> > after all slave request are done.
> > 
> > That is why it is named as master/slave. Actually Jens raised the similar concern
> > and I hate the name too, but it is always hard to figure out perfect name, or
> > any other name for reflecting the relation? (head/tail, fuse0/1 can't
> > do that, IMO)
> 
> Indeed. What about primary/secondary? And it'd be quite possible to have
> multiple secondaries too.

OK, I will take primary/secondary in V5 if no better name is suggested.


Thanks,
Ming

