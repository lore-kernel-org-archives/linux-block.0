Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C29AC001DF
	for <linux-block@archiver.kernel.org>; Tue,  1 Aug 2023 12:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjHAMN0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Aug 2023 08:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjHAMNZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Aug 2023 08:13:25 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CCB1999
        for <linux-block@vger.kernel.org>; Tue,  1 Aug 2023 05:13:23 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742eso60835415e9.3
        for <linux-block@vger.kernel.org>; Tue, 01 Aug 2023 05:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1690892002; x=1691496802;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=2Bg3vuHDK1chesb8Cvwh0EPT81VwLYoy6o1zjsPyDao=;
        b=E6qw1wML4+ZXUwDdL1Ej+y95ntDPygJiIhKDTHKYrn41FGkIC7CN++dKrHWleWOVPB
         afucCNg7x1yucKeOqzafkDMo/yB2zMetdAl28+Ze26wP2fCJPiEx6RtzH2GHCotEQp20
         RQs1S5dP633qmtjFXFkeBtZWd0iBp9dLqG4Fi2HaeH5+3w/kGdCL8pTy29U02UM9n7aC
         +Dy1jJP6vRZ7Qpv2xMXp61YVqQ41Qn7DCpMFyuepijOGA29yjAQHllouccd+A0MrGgF4
         N/RmI+Ld4oCJZ2kG5oZoqn6sKDvviQcx30dHe8986ow7E4xwfvWBTEzHhugVDtELk2Ju
         DAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690892002; x=1691496802;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Bg3vuHDK1chesb8Cvwh0EPT81VwLYoy6o1zjsPyDao=;
        b=M7E/hKcW97wI1P4iraD+LNJOiRBYyAihzH2IU8ZmONpr1lYgxg/8iVIXUATqTADPHD
         yFhLv2Q901diQYAkT5+PZKX30wmAjlCJeIyUOSrseVTXNXRJma9mzDMTf3oH4B1TXe+z
         h7iTtbcOXY0hEO6V7wQtPna5rpzuen/XPl0VXO+Ox4cwtbXGMscVNxTt+OgRR5QS8vGQ
         86vRl/XGGHSIh9jy08NlS9M2LMC8cZsXkw3f+j6PDz48WdNT5x+ZnVrtlTDwmIBUO91X
         LmOXHimDqf5wmA4K4qWSLb996Z3XJQ2G7kJOtBTWMEaOxcqgKKycRAAtMagQECN8j1aZ
         LPXg==
X-Gm-Message-State: ABy/qLamHdKcD3ve9s7TkgJg8sc+yNODUvmsGT+e0BPDRsDCKTeNXn+u
        YRzLfZ58lwf0OKPtKOtllIE04g==
X-Google-Smtp-Source: APBJJlECZozkp1Tnu+B2GrFE1jQBQCJFjyh4uah59/l6lR7k4sjW/vX6KGmGr0KKf1ydPTPAryCLVQ==
X-Received: by 2002:a1c:6a0e:0:b0:3fd:2e89:31bd with SMTP id f14-20020a1c6a0e000000b003fd2e8931bdmr2347615wmc.14.1690892001367;
        Tue, 01 Aug 2023 05:13:21 -0700 (PDT)
Received: from localhost ([147.161.155.108])
        by smtp.gmail.com with ESMTPSA id w17-20020a05600c015100b003fbfef555d2sm16518134wmm.23.2023.08.01.05.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 05:13:20 -0700 (PDT)
References: <20230714072510.47770-1-nmi@metaspace.dk>
 <20230714072510.47770-3-nmi@metaspace.dk> <ZLfQjNK5j5lB68C/@x1-carbon>
User-agent: mu4e 1.10.5; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Matias =?utf-8?Q?Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH v9 2/2] ublk: enable zoned storage support
Date:   Tue, 01 Aug 2023 14:11:56 +0200
In-reply-to: <ZLfQjNK5j5lB68C/@x1-carbon>
Message-ID: <87il9zot9c.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Niklas Cassel <Niklas.Cassel@wdc.com> writes:

> On Fri, Jul 14, 2023 at 09:25:10AM +0200, Andreas Hindborg wrote:
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>
> Hello Andreas!
>

<snip>

>>  	/* for READ request, writing data in iod->addr to rq buffers */
>> @@ -1120,6 +1404,11 @@ static void ublk_commit_completion(struct ublk_device *ub,
>>  	/* find the io request and complete */
>>  	req = blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
>>  
>> +	if (io->flags & UBLK_IO_FLAG_ZONE_APPEND) {
>
> Do we really need to introduce a completely new flag just for this?
>
> if (req_op(req) == REQ_OP_ZONE_APPEND)
>
> should work just as well, no?

Makes sense, thanks.

BR Andreas

