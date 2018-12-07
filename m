Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CB1C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 07:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE5220892
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 07:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="V242Bom6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE5220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbeLGHQt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 02:16:49 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:34968 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLGHQs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 02:16:48 -0500
Received: by mail-io1-f49.google.com with SMTP id i1so489659ioo.2
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 23:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=0o0zatD/MM4S5CmhrtMd7neYVTE/WwCr5i4pY3lrdz4=;
        b=V242Bom6AabHMrLiwP5PFLW+n8jX6b6ykoQjvlIiffZZbrTdBE/oiCDZktWGlPvQwV
         WOlFiNPL48wxQW0ndBlV6jZ++a9Do7nvlLj3M8ZqRj8ag5CIP16F9UbwIhtgCkBeP4sm
         P02pnvxqcWkqWDvunZz+sQilt+96yVo8+kxPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=0o0zatD/MM4S5CmhrtMd7neYVTE/WwCr5i4pY3lrdz4=;
        b=bi4VCW4uPfaV91n3fj9vO8uILzC3LMqPDNLhy6xcen/q+Rz1tB0nDoMXxbFmbKdzTh
         +Y2woyW5Dm0/zThkL8KvZzjTUalkERwk78QvCzWtZvpOyQr2jcNsZVY81sYBHm0hIjEc
         xMW1pXcFFAJm7+jpJVhZvok8OBKuk5Z7DM5cx9kMgXfrVAdB008xJaPWnogINkFCIBri
         /Fw0z8I7vOIoImrZzNYkyfuUrYE9gEt3/k68+8tDkcjGVc1Qs54/0Q52rltn61gXE93u
         V180kseuv9DP9OsSlMdvWtZ8LcWBCCmigEsJwd9gpfpFXjvU616Y9xr3VUl0JAVHmGaU
         xmDA==
X-Gm-Message-State: AA+aEWa6XnTFpr7xrbw8COU5yrrreWMNM118z6QJjAHBIJzqMlF3YvQW
        rbNSWKR4kCc1U68Gy2NgZaknZomgEfXHmw9vKkXZmw==
X-Google-Smtp-Source: AFSGD/XoEitpobN8TH/f6hhfH5YdSOD2umpLYS6QLGnEluMNZIqLrCWdWNwgiwEBUgZpLyH1BLO39AkKZuy/9TkxsWE=
X-Received: by 2002:a5e:9510:: with SMTP id r16mr723144ioj.224.1544167006798;
 Thu, 06 Dec 2018 23:16:46 -0800 (PST)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <1543943674.185366.194.camel@acm.org> <ce2cdcee7e8d8e21cc8398a882b9d6e3@mail.gmail.com>
 <20181206003323.GB3015@ming.t460p> <9e57309d7f40c35c1096b6f932c02f68@mail.gmail.com>
 <b7a44ebf-8996-aee3-3aaf-2ca18622d161@kernel.dk>
In-Reply-To: <b7a44ebf-8996-aee3-3aaf-2ca18622d161@kernel.dk>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIDGsA5xuRcZ0ZzYKBZCDlABhVdmwHqGsmwAaocH2YATD8ANgGV5kX8pOoETAA=
Date:   Fri, 7 Dec 2018 12:46:44 +0530
Message-ID: <cf0b27a5c09afb21aeef0ea8392161dc@mail.gmail.com>
Subject: RE: +AFs-PATCH+AF0- blk-mq: Set request mapping to NULL in blk+AF8-mq+AF8-put+AF8-driver+AF8-tag
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On 12/5/18 10:45 PM, Kashyap Desai wrote:
> >>
> >> If the 'tag' passed to scsi_host_find_tag() is valid, I think there
> >> shouldn't have such issue.
> >>
> >> If you want to find outstanding IOs, maybe you can try
> >> blk_mq_queue_tag_busy_iter()
> >> or blk_mq_tagset_busy_iter(), because you may not know if the passed
> > 'tag'
> >> to
> >> scsi_host_find_tag() is valid or not.
> >
> > We tried quick change in mpt3sas driver using blk_mq_tagset_busy_iter
> > and
> > it returns/callback for valid requests (no stale entries are returned).
> > Expected.
> > Above two APIs are only for blk-mq.  What about non-mq case ? Driver
> > should use scsi_host_find_tag for non-mq and blk_mq_tagset_busy_iter for
> > blk-mq case ?
> > I don't see that will be good interface. Also, blk_mq_tagset_busy_iter
> > API
> > does not provide control if driver wants to quit in-between or do some
> > retry logic etc.
> >
> > Why can't we add single API which provides the correct output.
>
> From 4.21 and forward, there will only be blk/scsi-mq. This is exactly
> the problem with having to maintain two stacks, it's a huge pain.

Hi Jens, Fix for this issue also required to be back ported to stable
kernels (which still use non-mq + mq stack).
We have multiple choices to fix this.

1. Use " blk_mq_tagset_busy_iter" in *all* the affected drivers. This API
has certain limitation as explained and also fix only blk-mq part. Using
this API may need more code in low level drivers to handle non-mq and mq
separately.
2. Driver can use internal memory for scsiio_track (driver private) and
track all the outstanding IO within a driver. This is mostly a scsi mid
layer interface. All the affected driver require a changes.
3. Fix blk-mq code around  blk_mq_put_tag and driver can still use "
scsi_host_find_tag". No driver changes are required.
This is smooth to back port stable kernel and Linux Distribution which
normally pick critical fixes from stable can pick the fix. This is better
fix and did not change any design.
In fact, I mimic the same flow as non-mq code is doing.

I don't see any design or functional issue with #3 (PATCH provided in this
thread.) What is your feedback for this patch ?

Kashyap

>
> --
> Jens Axboe
