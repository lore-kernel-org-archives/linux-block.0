Return-Path: <SRS0=xEhu=UI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA89C28EBD
	for <linux-block@archiver.kernel.org>; Sun,  9 Jun 2019 16:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B747206DF
	for <linux-block@archiver.kernel.org>; Sun,  9 Jun 2019 16:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560096433;
	bh=dvad/Tm3psKQuRT8N/Lve0sdC+s0akZaWtx6hHIFeUU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yCQ/NNItjzSdMfUdh2wZNpnc4PnbkPsbruWWB2h0p/Mhmhihyb3rzxYusAgWpQD0f
	 WkLO5flzIGhEo9OksrTGdx6I/8ulCA5F3F73miE0/o1kvYUD8/flSnB71s20QZScJ5
	 BhwSU1r7txTAUNWFzKYuU+oMEt+2NUbYSmGO29ZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbfFIQHM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:07:12 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35828 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbfFIQHM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Jun 2019 12:07:12 -0400
Received: by mail-lf1-f65.google.com with SMTP id a25so4960377lfg.2
        for <linux-block@vger.kernel.org>; Sun, 09 Jun 2019 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ppJwFc/HoFZ6c4u1RkF1IuOTgq2N0u017cUH26hLYpU=;
        b=UP87CBsEEZO+F7JurUvO+4qJii1nI1v0e/42LAa5HvDh1FNnRnFD/6O1VzPnbhrHEM
         YPyvR9nUOUbs1Dv0Ucufy2oLWB3mj0rNtohxf5+IiFOeLWTz9Z6W8flqEdsYscKRfoGu
         DdZH5aE3VU/8jQ8nqg7Bad2E8CxGs/NwhIKkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ppJwFc/HoFZ6c4u1RkF1IuOTgq2N0u017cUH26hLYpU=;
        b=uN1uVa8Z3mz28towdcTJZYp09dr+abkVU0rKMS1kuhaJMpEVL7Gz6nXFtY0jsLwBkd
         PCLt4OGNyM/ViLL1Btg3cswHGYDX2ORltLyTsQpVqlbXvAN06QQmigyi9/wgBH8Z2qm1
         hF3Qzyc1fhIwxxSWo0yiS5MJ2Is+gu+ZX3nHK5WoRbWA/g5VG30N4yP+c2Adc5gR8FjL
         NnVRe+9nJrhMKBfgL8eG6TKslb4VUVZH5p7boRKlj6vmQ4I/aTzXd4T28R+dWcntbFiP
         Q8UQSjvFZ2YMB960Tgvo6PKYnptUh0Xshmgt3OZW/A+7LrqUSzRgJ240rcce6WPVjlzN
         EVXw==
X-Gm-Message-State: APjAAAU/2O/DSZ1+VbgiZubCMCthNMKzmtMIHuubYMGCkKLWR9eV2GTt
        UdrR+AQ5XftPa3pxbyXGp3g/Wagv08w=
X-Google-Smtp-Source: APXvYqyp02j/ia1M0icwiy8YtlI9REDLOZ0huvdIdUXM4lLHrYxRXBTEjkN4B6gKqD2B773etrImew==
X-Received: by 2002:ac2:50cd:: with SMTP id h13mr30202484lfm.36.1560096429111;
        Sun, 09 Jun 2019 09:07:09 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 1sm1416925ljt.78.2019.06.09.09.07.07
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 09:07:08 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id p24so4949119lfo.6
        for <linux-block@vger.kernel.org>; Sun, 09 Jun 2019 09:07:07 -0700 (PDT)
X-Received: by 2002:ac2:59c9:: with SMTP id x9mr31860260lfn.52.1560096427434;
 Sun, 09 Jun 2019 09:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <4f801c9b-4ab6-9a11-536c-ff509df8aa56@kernel.dk>
 <CAHk-=whXfPjCtc5+471x83WApJxvxzvSfdzj_9hrdkj-iamA=g@mail.gmail.com> <52daccae-3228-13a1-c609-157ab7e30564@kernel.dk>
In-Reply-To: <52daccae-3228-13a1-c609-157ab7e30564@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Jun 2019 09:06:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whca9riMqYn6WoQpuq9ehQ5KfBvBb4iVZ314JSfvcgy9Q@mail.gmail.com>
Message-ID: <CAHk-=whca9riMqYn6WoQpuq9ehQ5KfBvBb4iVZ314JSfvcgy9Q@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 5.2-rc4
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000005f9e3b058ae641c3"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--0000000000005f9e3b058ae641c3
Content-Type: text/plain; charset="UTF-8"

On Sat, Jun 8, 2019 at 11:00 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> FWIW, the concept/idea goes back a few months and was discussed with
> the cgroup folks. But I totally agree that the implementation could
> have been cleaner, especially at this point in time.
>
> I'm fine with you reverting those two patches for 5.2 if you want to,
> and the BFQ folks can do this more cleanly for 5.3.

I don't think the code is _broken_, and I don't think the link_name
thing is wrong. So no point in reverting unless we see more issues.

I just wish it had been done differently, both from the patch details
standpoint, but also in making sure the cgroup people were aware (and
maybe they were, but it certainly didn't show up in the commit).

So I think an incremental patch like the attached would make the code
easier to understand (I really do mis-like random boolean flags being
passed around that change behavior in undocumented and non-obvious
ways), but I'd also want to make sure that Tejun & co are all on board
and know about it..

I'm sure this happens a lot, but during the rc series I just end up
*looking* at details like this a lot more, when I see changes outside
of a subsystem directory.

Tejun&co, we're talking about commit 54b7b868e826 ("cgroup: let a
symlink too be created with a cftype file") which didn't have any sign
of you guys being aware of it or having acked it.

                   Linus

--0000000000005f9e3b058ae641c3
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jwp4ys9a0>
X-Attachment-Id: f_jwp4ys9a0

IGtlcm5lbC9jZ3JvdXAvY2dyb3VwLmMgfCAxMiArKysrKy0tLS0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEva2VybmVsL2Nn
cm91cC9jZ3JvdXAuYyBiL2tlcm5lbC9jZ3JvdXAvY2dyb3VwLmMKaW5kZXggMTU1MDQ4YjBlY2Ey
Li5mYTI1ZjBmNmZlMjMgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9jZ3JvdXAvY2dyb3VwLmMKKysrIGIv
a2VybmVsL2Nncm91cC9jZ3JvdXAuYwpAQCAtMTQ2MSw3ICsxNDYxLDcgQEAgc3RydWN0IGNncm91
cCAqdGFza19jZ3JvdXBfZnJvbV9yb290KHN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzaywKIHN0YXRp
YyBzdHJ1Y3Qga2VybmZzX3N5c2NhbGxfb3BzIGNncm91cF9rZl9zeXNjYWxsX29wczsKIAogc3Rh
dGljIGNoYXIgKmNncm91cF9maWxsX25hbWUoc3RydWN0IGNncm91cCAqY2dycCwgY29uc3Qgc3Ry
dWN0IGNmdHlwZSAqY2Z0LAotCQkJICAgICAgY2hhciAqYnVmLCBib29sIHdyaXRlX2xpbmtfbmFt
ZSkKKwkJCSAgICAgIGNoYXIgKmJ1ZiwgY29uc3QgY2hhciAqbmFtZSkKIHsKIAlzdHJ1Y3QgY2dy
b3VwX3N1YnN5cyAqc3MgPSBjZnQtPnNzOwogCkBAIC0xNDcwLDExICsxNDcwLDkgQEAgc3RhdGlj
IGNoYXIgKmNncm91cF9maWxsX25hbWUoc3RydWN0IGNncm91cCAqY2dycCwgY29uc3Qgc3RydWN0
IGNmdHlwZSAqY2Z0LAogCQljb25zdCBjaGFyICpkYmcgPSAoY2Z0LT5mbGFncyAmIENGVFlQRV9E
RUJVRykgPyAiLl9fREVCVUdfXy4iIDogIiI7CiAKIAkJc25wcmludGYoYnVmLCBDR1JPVVBfRklM
RV9OQU1FX01BWCwgIiVzJXMuJXMiLAotCQkJIGRiZywgY2dyb3VwX29uX2RmbChjZ3JwKSA/IHNz
LT5uYW1lIDogc3MtPmxlZ2FjeV9uYW1lLAotCQkJIHdyaXRlX2xpbmtfbmFtZSA/IGNmdC0+bGlu
a19uYW1lIDogY2Z0LT5uYW1lKTsKKwkJCSBkYmcsIGNncm91cF9vbl9kZmwoY2dycCkgPyBzcy0+
bmFtZSA6IHNzLT5sZWdhY3lfbmFtZSwgbmFtZSk7CiAJfSBlbHNlIHsKLQkJc3Ryc2NweShidWYs
IHdyaXRlX2xpbmtfbmFtZSA/IGNmdC0+bGlua19uYW1lIDogY2Z0LT5uYW1lLAotCQkJQ0dST1VQ
X0ZJTEVfTkFNRV9NQVgpOworCQlzdHJzY3B5KGJ1ZiwgbmFtZSwgQ0dST1VQX0ZJTEVfTkFNRV9N
QVgpOwogCX0KIAlyZXR1cm4gYnVmOwogfQpAQCAtMTQ4MiwxMyArMTQ4MCwxMyBAQCBzdGF0aWMg
Y2hhciAqY2dyb3VwX2ZpbGxfbmFtZShzdHJ1Y3QgY2dyb3VwICpjZ3JwLCBjb25zdCBzdHJ1Y3Qg
Y2Z0eXBlICpjZnQsCiBzdGF0aWMgY2hhciAqY2dyb3VwX2ZpbGVfbmFtZShzdHJ1Y3QgY2dyb3Vw
ICpjZ3JwLCBjb25zdCBzdHJ1Y3QgY2Z0eXBlICpjZnQsCiAJCQkgICAgICBjaGFyICpidWYpCiB7
Ci0JcmV0dXJuIGNncm91cF9maWxsX25hbWUoY2dycCwgY2Z0LCBidWYsIGZhbHNlKTsKKwlyZXR1
cm4gY2dyb3VwX2ZpbGxfbmFtZShjZ3JwLCBjZnQsIGJ1ZiwgY2Z0LT5uYW1lKTsKIH0KIAogc3Rh
dGljIGNoYXIgKmNncm91cF9saW5rX25hbWUoc3RydWN0IGNncm91cCAqY2dycCwgY29uc3Qgc3Ry
dWN0IGNmdHlwZSAqY2Z0LAogCQkJICAgICAgY2hhciAqYnVmKQogewotCXJldHVybiBjZ3JvdXBf
ZmlsbF9uYW1lKGNncnAsIGNmdCwgYnVmLCB0cnVlKTsKKwlyZXR1cm4gY2dyb3VwX2ZpbGxfbmFt
ZShjZ3JwLCBjZnQsIGJ1ZiwgY2Z0LT5saW5rX25hbWUpOwogfQogCiAvKioK
--0000000000005f9e3b058ae641c3--
