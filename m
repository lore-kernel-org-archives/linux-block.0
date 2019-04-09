Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586EDC10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 15:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E462133D
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 15:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dl2mM+r7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfDIP4X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:56:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37656 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfDIP4X (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 11:56:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so3946731wmf.2;
        Tue, 09 Apr 2019 08:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rPLakgrDxu4fh/4aX9fjdIImOp0Qf8vKIYt8geqyYzM=;
        b=dl2mM+r75I7C7zcbjiFPX3CK65tCKG4kXyqxFqhoav6p8QL4YoCeBJ1fBMAE8qQniD
         WQE8jZLQlMbX2a8F1rjU38e8uq7ygfhiedKRhuM573kioKNOITMkNfB2MGuFJPiyeqvi
         4yIjAbjjHDrJQhlJ4iRgBVXRePjag6/gsmZH17lNaI8jvl9g4ZSXzPiODziIvRGq9SBG
         APtQTkw5nUKbIPKINsb7RhtJ4Ts6ezCTobEM5Yw6xmX3c4aVhIjKeA0PL/1RoH86o88S
         xfQ7nzU+lsS6380hIe57kYIWzbrgWfs6M7Eqo/lseirVYumUisE91bSm7jDtvwIRAQMx
         bdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPLakgrDxu4fh/4aX9fjdIImOp0Qf8vKIYt8geqyYzM=;
        b=AlsGgzKYw0wg1uUo6IXUg0ggwvo9JjRieSXz1ZmiAfxK6wy5hM/41kaXjhujC45aQ7
         4kaB2d5dJXJUOs61s/1ycPVsZERSpXFnY+6720r65eg/RA8tlaak9GvfxREwd0GCW5NB
         BJwCNXABCXmBip+07ROBfbJlMt7QZdRfa+uIqU7/cKq7aIH8jUX1ogYmSBMNG3p7eGtf
         xT6sgZGc3G1+efkNdrAiFA3jdXC7IyxKyOFL6ITFMBHLqcv7nm35jPh/aErBdEYpU6c2
         MDlaP6/LL29xx7hKRwPFpE6dO8tjVLybc6S/DB79PuKKgik8uRrFBBgGvxRpHMfLqc48
         hXgA==
X-Gm-Message-State: APjAAAV8fFjNMBbuQLt9xbV5SCDnIbC0VwXbZtKanSGrTZoWphEYIZPC
        5TycRvHxwBpjGUH5RhxxAY1ue2am5vzvjFB30d4=
X-Google-Smtp-Source: APXvYqwwyxA7Aui2VQMMpjUfANbU5UTqchg1Yl3tTH38Daz3TKofBBREKv46SZKu/NHw8Ef0gVLgH3+KVBq386EDcy8=
X-Received: by 2002:a7b:c00b:: with SMTP id c11mr21412339wmb.23.1554825381262;
 Tue, 09 Apr 2019 08:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <26C1E17D-86C3-42A9-AC21-DBB4554FB901@digi.com> <Pine.LNX.4.44L0.1904091057120.1599-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1904091057120.1599-100000@iolanthe.rowland.org>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 9 Apr 2019 23:56:09 +0800
Message-ID: <CACVXFVOXSzw=MzkTUG9UFBH=132BVpACa4QRxVKi83xOM9EBgw@mail.gmail.com>
Subject: Re: Bug: VHCI + USB 3.0
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Bollinger, Seth" <Seth.Bollinger@digi.com>,
        Jens Axboe <axboe@kernel.dk>,
        USB list <linux-usb@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 9, 2019 at 11:20 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Tue, 9 Apr 2019, Bollinger, Seth wrote:
>
> > > No, that trace did not show any failure.  Did you see the corresponding
> > > error messages in the kernel log while you were collecting the trace?
> > > Maybe you can try again.
> >
> > Ok, I have it this time.  I must have sniffed the wrong bus last time.
> >
> > 2019-04-09 13:09:32 AW24-D00005 user.notice awusbd[2514]: bulk A 000004bf ty 03 st 00000000 T 3584 L 0 ch 00000081 ep 1 fl 0
> > 2019-04-09 13:09:32 AW24-D00005 user.notice awusbd[2514]: bulk A 000004bf ty 03 st 00000000 T 4096 L 0 ch 00000081 ep 1 fl 0
> > 2019-04-09 13:09:32 AW24-D00005 user.notice awusbd[2514]: message repeated 2 times: [ bulk A 000004bf ty 03 st 00000000 T 4096 L 0 ch 00000081 ep 1 fl 0]
> > 2019-04-09 13:09:32 AW24-D00005 user.notice awusbd[2514]: BI completion: st 0 stat -75 AL 0 ec 0 returning -75
> > 2019-04-09 13:09:32 AW24-D00005 user.notice awusbd[2514]: bulk A 000004bf ty 03 st 00000000 T 4096 L 0 ch 00000081 ep 1 fl 0
> > 2019-04-09 13:09:32 AW24-D00005 user.notice awusbd[2514]: message repeated 3 times: [ bulk A 000004bf ty 03 st 00000000 T 4096 L 0 ch 00000081 ep 1 fl 0]
> > 2019-04-09 13:09:32 AW24-D00005 user.notice awusbd[2514]: BI completion: st 0 stat -2 AL 0 ec 0 returning -2
> > 2019-04-09 13:09:32 AW24-D00005 user.notice awusbd[2514]: message repeated 6 times: [ BI completion: st 0 stat -2 AL 0 ec 0 returning -2]
> > 2019-04-09 13:09:32 AW24-D00005 user.notice awusbd[2514]: bulk A 000004bf ty 03 st 00000000 T 13 L 0 ch 00000081 ep 0 fl 4271644
> > 2019-04-09 13:09:32 AW24-D00005 user.notice awusbd[2514]: BI completion: st 0 stat -71 AL 0 ec 0 returning -71
>
> All right, now I see the problem.  It's here:
>
> > ffff800074057b40 1058554625 S Bo:2:098:2 -115 31 = 55534243 07010000 007e0000 80000a28 000001ff c100003f 00000000 000000
> > ffff800074057b40 1058554638 C Bo:2:098:2 0 31 >
> > ffff800074057cc0 1058555039 S Bi:2:098:1 -115 3584 <
> > ffff800074057cc0 1058555066 C Bi:2:098:1 -75 3584 = 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > ffff800073e0fb40 1058555113 S Bi:2:098:1 -115 4096 <
> > ffff8000723f5f00 1058555129 S Bi:2:098:1 -115 4096 <
> > ffff8000723f5c00 1058555148 S Bi:2:098:1 -115 4096 <
> > ffff8000723f5b40 1058555202 S Bi:2:098:1 -115 4096 <
> > ffff8000723f5a80 1058555224 S Bi:2:098:1 -115 4096 <
> > ffff8000711d8780 1058555237 S Bi:2:098:1 -115 4096 <
> > ffff800074091900 1058555255 S Bi:2:098:1 -115 4096 <
> > ffff800073e0fb40 1058555769 C Bi:2:098:1 -2 4096 = 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>
> This is a READ command asking for 63 blocks (31.5 KB) of data.  The
> device sends 7 4096-byte packets followed by a 3584-byte packet, but
> the kernel's scatter-gather list contains a 3584-byte buffer followed
> by 7 4096-byte buffers.  Since the VHCI driver doesn't have full native
> SG support, it needs each packet to be stored in a contiguous region of
> memory.  In this case the first packet causes an overrun error.
>
> The best way to fix the problem would be to improve the SG support in
> VHCI.  Short of that, we would like to tell the block layer that this
> device requires all scatterlist elements (except the last one) for any
> single command to be multiples of 1024 bytes, in spite of the fact that
> the device claims to have a block size of 512 bytes.

You may try the following limit:

     blk_queue_virt_boundary(q, 1024 - 1);


Thanks,
Ming Lei
