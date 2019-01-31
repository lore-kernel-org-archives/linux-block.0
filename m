Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90B7C169C4
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 19:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA083218AF
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 19:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfAaTmH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:42:07 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:39845 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfAaTmG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Jan 2019 14:42:06 -0500
Received: by mail-lf1-f43.google.com with SMTP id n18so3245756lfh.6
        for <linux-block@vger.kernel.org>; Thu, 31 Jan 2019 11:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cmRbTXrfWlFCmdufYsmjYos3LulOEOUcXPN4Hcaws4c=;
        b=lw9BLW8yyrW0PfSLBn6rpkFS0h0HGJ5zyo2k1XrnHTUTBnLxcsZ84/vE8Nzi31bGNk
         ZEy/FRqGr0nyFeBR9V3d/NW5k9h9sKbOCfqCQ6F6U/7M9qcaaJo/po9RQDu0msHGKnyD
         QNPhoYAqy9xMfQkubq3U9wnNySBc6Pgw7tSVWo+nwKsxHZzWg3nz3gMxjfru6iOu8izS
         By3VLU+ON2eLXftI+s5Tguzs4fpuFGPnCM79GvgQGyQWQ+UgRp90cy14r6BJQTDvnAqR
         38hnJynITRp6BPN9ethtDmwoFSvHq6nprp0ceoN2LoJzWo3hhN5YGWHewUWegpTmFL1M
         adyg==
X-Gm-Message-State: AJcUukfXSARuTbicp3/2wuyMCYGOXVfEFRZMO3MenSLMuHmtHnc5doBA
        +F48rHUxSlOuVhQmZoV7vDPTsPlwwzhTcfVsKtdD8Q==
X-Google-Smtp-Source: ALg8bN6eUunRTWS63XuntNqv0tVB8SxpXAUJx6loGSYxGAqKiGFRRVEmHq8Yc0iwiS9LyrxvAc3Oj+rNXA2A2vv2x90=
X-Received: by 2002:a19:4dd0:: with SMTP id a199mr29532821lfb.42.1548963724712;
 Thu, 31 Jan 2019 11:42:04 -0800 (PST)
MIME-Version: 1.0
References: <20190125021107.4595-1-zhangxiaoxu5@huawei.com>
 <CAMeeMh_=UVGwo-=9WtBXRmiHTXnLAswqis97bM-aiuwnzPU0QQ@mail.gmail.com>
 <20190128221441.GA24102@redhat.com> <yq1lg34f4i7.fsf@oracle.com>
 <CAMeeMh85T_qui=LWd0u=b_oMN5XLqowqkvLuYGBM2Ae6tS-mzg@mail.gmail.com> <20190131103924.GA22503@infradead.org>
In-Reply-To: <20190131103924.GA22503@infradead.org>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Thu, 31 Jan 2019 14:41:52 -0500
Message-ID: <CAMeeMh-uxiee7rKutnr3jrMjzkc8=R2Y3DPPBLvLYjqSwjfi_w@mail.gmail.com>
Subject: Re: block: Fix a WRITE SAME BUG_ON
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Alasdair G Kergon <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 31, 2019 at 5:39 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Jan 30, 2019 at 09:08:50AM -0500, John Dorminy wrote:
> > (I use WRITE_SAME to fill devices with a particular pattern in order
> > to catch failures to initialize disk structures appropriately,
> > personally, but it's just for convenience/speed.)
>
> How do you use it?  We don't have a user interface to generate
> REQ_OP_WRITE_SAME requests.

A not-checked-in test module, similar to Zhang Xiaoxu's reproducer,
exposing a sysfs node to trigger filling a block device with a test
pattern.
