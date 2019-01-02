Return-Path: <SRS0=PKU6=PK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA55C43387
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 18:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9194D218E2
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 18:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TNqL2HQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbfABSzd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:55:33 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:36505 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbfABSzc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jan 2019 13:55:32 -0500
Received: by mail-lj1-f172.google.com with SMTP id g11-v6so27790250ljk.3
        for <linux-block@vger.kernel.org>; Wed, 02 Jan 2019 10:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sh8zxcFhJka7LGz8ibproSXYVfmdQX/SBzpAO7997Bw=;
        b=TNqL2HQx/QPRTc8kgmJpyjNDvp6yVCSDIB2PR/sOZl+Zo5gsNldeNsmEhWKDeelGOu
         mZ4dGcnls4Y6JFH5BnvyF3DGvNInRLOB3UYwlFNpGUmk06/BWf0TAm/qd4qT7caOVBew
         40+y3+x7LRw0B8H8hX3VfJk/dPkDQSIIq0fuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sh8zxcFhJka7LGz8ibproSXYVfmdQX/SBzpAO7997Bw=;
        b=QuZWxN4d0F7LxxnpOX+SfRN7VrBtzvR0hu3v8a49bFvpzRl89zm2jukJ0rl8E0qW4G
         omxmPLARU6IuTrNXL1BV03lKWckE3LkLxbPt9BWfBtkN50Xln1vVGP3EMY7Ekh2YGOa9
         0tXbDv1fSuXtoVBJNrzWIFKOkYTh/6M9wDyewfZSwtULZjW7C8bbvcY/0RBsgRA3tNQL
         lJFVkUdlU55SRQFB9HZ9NF+KxDBEzgeQM4l8zVGVSTsTQ3oV2DKrqz6OuvzCG+zhLCPu
         ZrpMGEich2E8VNBU077b53AFAAcjX7jLSD118quXMgC8xqx7rWnnzl/Y+a0UErlnR/1H
         eNZw==
X-Gm-Message-State: AA+aEWbKIFxVW/d96zcQFkS9Bn8k9wS9TAOYD9/vFa02mT/oI0djn36v
        aOHlcqzEpkH2+8ojnedMwllKfNmlLKY=
X-Google-Smtp-Source: ALg8bN7JTOL3g1Ee+PSIz2KJqv8MUlP3lFdfbPwmAGGR751XS1BjgJsszGu+Xl85xZYucaKDBTiFVw==
X-Received: by 2002:a2e:5356:: with SMTP id t22-v6mr23822784ljd.26.1546455329498;
        Wed, 02 Jan 2019 10:55:29 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id z6sm10156708lfa.87.2019.01.02.10.55.28
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 10:55:28 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id y14so2666290lfg.13
        for <linux-block@vger.kernel.org>; Wed, 02 Jan 2019 10:55:28 -0800 (PST)
X-Received: by 2002:a19:c014:: with SMTP id q20mr20434579lff.16.1546455328095;
 Wed, 02 Jan 2019 10:55:28 -0800 (PST)
MIME-Version: 1.0
References: <181e0aa7-34a5-5445-70b2-45770a81659d@kernel.dk>
 <CAHk-=wicNcMhY_YCkT5Nsdcxake8x+sfYUByvbhTzp2v-LWjeA@mail.gmail.com>
 <CAHk-=whcmNjH+3pP_tgKbxe3iNu20eVVxfDyVXrKsNf7HiR0WA@mail.gmail.com> <9d2da835-fe54-947a-85da-cedb4423bca0@kernel.dk>
In-Reply-To: <9d2da835-fe54-947a-85da-cedb4423bca0@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Jan 2019 10:55:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=whz9-ren=HOTcofA0hCROWnVijTDGUgKaEVwkVjf2_CZg@mail.gmail.com>
Message-ID: <CAHk-=whz9-ren=HOTcofA0hCROWnVijTDGUgKaEVwkVjf2_CZg@mail.gmail.com>
Subject: Re: block: only use __set_current_state() for polled IO
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: multipart/mixed; boundary="0000000000007e3461057e7e3053"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--0000000000007e3461057e7e3053
Content-Type: text/plain; charset="UTF-8"

On Wed, Jan 2, 2019 at 10:14 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> Note that the blk-mq hunk is fine, since that's ONLY used for polling.

Actually, it's fine for another reason too: using
"__set_current_state()" is always safe when the state you're setting
things to is TASK_RUNNING. Even if there's a concurrent wakeup, that's
only going to set things running anyway, so there's no race.

But yes, if something is truly just polling, then it shouldn't touch
the task state at all.

That said, some of the "polling" code looks mis-named. For example,
the blk_poll() call in mm/page_io.c looks like it's polling, but it
can actually sleep (ie blk_mq_poll_hybrid() gets called even when
"spin" is true).

But the sleeping case looks like it handles the task state thing on
its own, so all those polling codepaths should probably be inspected.

In the meantime, the attached is what I committed.

                     Linus

--0000000000007e3461057e7e3053
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jqfjk9tl0>
X-Attachment-Id: f_jqfjk9tl0

Y29tbWl0IDFhYzVjZDQ5Nzg3OTRiZDA2MGQ0NDhhY2MwMzA1ZTlmYzk5NmJhOTIKQXV0aG9yOiBM
aW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+CkRhdGU6ICAgV2Vk
IEphbiAyIDEwOjQ2OjAzIDIwMTkgLTA4MDAKCiAgICBibG9jazogZG9uJ3QgdXNlIHVuLW9yZGVy
ZWQgX19zZXRfY3VycmVudF9zdGF0ZShUQVNLX1VOSU5URVJSVVBUSUJMRSkKICAgIAogICAgVGhp
cyBtb3N0bHkgcmV2ZXJ0cyBjb21taXQgODQ5YTM3MDAxNmE1ICgiYmxvY2s6IGF2b2lkIG9yZGVy
ZWQgdGFzawogICAgc3RhdGUgY2hhbmdlIGZvciBwb2xsZWQgSU8iKS4gIEl0IHdhcyB3cm9uZ2x5
IGNsYWltaW5nIHRoYXQgdGhlIG9yZGVyaW5nCiAgICB3YXNuJ3QgbmVjZXNzYXJ5LiAgVGhlIG1l
bW9yeSBiYXJyaWVyIF9pc18gbmVjZXNzYXJ5LgogICAgCiAgICBJZiBzb21ldGhpbmcgaXMgdHJ1
bHkgcG9sbGluZyBhbmQgbm90IGdvaW5nIHRvIHNsZWVwLCBpdCdzIHRoZSB3aG9sZQogICAgc3Rh
dGUgc2V0dGluZyB0aGF0IGlzIHVubmVjZXNzYXJ5LCBub3QgdGhlIG1lbW9yeSBiYXJyaWVyLiAg
V2hlbmV2ZXIgeW91CiAgICBzZXQgeW91ciBzdGF0ZSB0byBhIHNsZWVwaW5nIHN0YXRlLCB5b3Ug
YWJzb2x1dGVseSBuZWVkIHRoZSBtZW1vcnkKICAgIGJhcnJpZXIuCiAgICAKICAgIE5vdGUgdGhh
dCBzb21ldGltZXMgdGhlIG1lbW9yeSBiYXJyaWVyIGNhbiBiZSBlbHNld2hlcmUuICBGb3IgZXhh
bXBsZSwKICAgIHRoZSBvcmRlcmluZyBtaWdodCBiZSBwcm92aWRlZCBieSBhbiBleHRlcm5hbCBs
b2NrLCBvciBieSBzZXR0aW5nIHRoZQogICAgcHJvY2VzcyBzdGF0ZSB0byBzbGVlcGluZyBiZWZv
cmUgYWRkaW5nIHlvdXJzZWxmIHRvIHRoZSB3YWl0IHF1ZXVlIGxpc3QKICAgIHRoYXQgaXMgdXNl
ZCBmb3Igd2FraW5nIHVwICh3aGVyZSB0aGUgd2FpdCBxdWV1ZSBsb2NrIGl0c2VsZiB3aWxsCiAg
ICBndWFyYW50ZWUgdGhhdCBhbnkgd2FrZXVwIHdpbGwgY29ycmVjdGx5IHNlZSB0aGUgc2xlZXBp
bmcgc3RhdGUpLgogICAgCiAgICBCdXQgbm9uZSBvZiB0aG9zZSBjYXNlcyB3ZXJlIHRydWUgaGVy
ZS4KICAgIAogICAgTk9URSEgU29tZSBvZiB0aGUgcG9sbGluZyBwYXRocyBtYXkgaW5kZWVkIGJl
IGFibGUgdG8gZHJvcCB0aGUgc3RhdGUKICAgIHNldHRpbmcgZW50aXJlbHksIGF0IHdoaWNoIHBv
aW50IHRoZSBtZW1vcnkgYmFycmllciBhbHNvIGdvZXMgYXdheS4KICAgIAogICAgKEFsc28gbm90
ZSB0aGF0IHRoaXMgZG9lc24ndCByZXZlcnQgdGhlIFRBU0tfUlVOTklORyBjYXNlczogdGhlcmUg
aXMgbm8KICAgIHJhY2UgYmV0d2VlbiBhIHdha2V1cCBhbmQgc2V0dGluZyB0aGUgcHJvY2VzcyBz
dGF0ZSB0byBUQVNLX1JVTk5JTkcsCiAgICBzaW5jZSB0aGUgZW5kIHJlc3VsdCBkb2Vzbid0IGRl
cGVuZCBvbiBvcmRlcmluZykuCiAgICAKICAgIENjOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwu
ZGs+CiAgICBDYzogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+CiAgICBTaWduZWQtb2Zm
LWJ5OiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+CgpkaWZm
IC0tZ2l0IGEvZnMvYmxvY2tfZGV2LmMgYi9mcy9ibG9ja19kZXYuYwppbmRleCA0NTBiZTg4Y2Zm
ZWYuLmM1NDZjZGNlNzdlNiAxMDA2NDQKLS0tIGEvZnMvYmxvY2tfZGV2LmMKKysrIGIvZnMvYmxv
Y2tfZGV2LmMKQEAgLTIzNywxMSArMjM3LDkgQEAgX19ibGtkZXZfZGlyZWN0X0lPX3NpbXBsZShz
dHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAqaXRlciwKIAogCXFjID0gc3VibWl0
X2JpbygmYmlvKTsKIAlmb3IgKDs7KSB7Ci0JCV9fc2V0X2N1cnJlbnRfc3RhdGUoVEFTS19VTklO
VEVSUlVQVElCTEUpOwotCisJCXNldF9jdXJyZW50X3N0YXRlKFRBU0tfVU5JTlRFUlJVUFRJQkxF
KTsKIAkJaWYgKCFSRUFEX09OQ0UoYmlvLmJpX3ByaXZhdGUpKQogCQkJYnJlYWs7Ci0KIAkJaWYg
KCEoaW9jYi0+a2lfZmxhZ3MgJiBJT0NCX0hJUFJJKSB8fAogCQkgICAgIWJsa19wb2xsKGJkZXZf
Z2V0X3F1ZXVlKGJkZXYpLCBxYywgdHJ1ZSkpCiAJCQlpb19zY2hlZHVsZSgpOwpAQCAtNDI2LDgg
KzQyNCw3IEBAIF9fYmxrZGV2X2RpcmVjdF9JTyhzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBp
b3ZfaXRlciAqaXRlciwgaW50IG5yX3BhZ2VzKQogCQlyZXR1cm4gLUVJT0NCUVVFVUVEOwogCiAJ
Zm9yICg7OykgewotCQlfX3NldF9jdXJyZW50X3N0YXRlKFRBU0tfVU5JTlRFUlJVUFRJQkxFKTsK
LQorCQlzZXRfY3VycmVudF9zdGF0ZShUQVNLX1VOSU5URVJSVVBUSUJMRSk7CiAJCWlmICghUkVB
RF9PTkNFKGRpby0+d2FpdGVyKSkKIAkJCWJyZWFrOwogCmRpZmYgLS1naXQgYS9mcy9pb21hcC5j
IGIvZnMvaW9tYXAuYwppbmRleCAzYTBjZDU1N2I0Y2YuLmEzMDg4ZmFlNTY3YiAxMDA2NDQKLS0t
IGEvZnMvaW9tYXAuYworKysgYi9mcy9pb21hcC5jCkBAIC0xOTIxLDggKzE5MjEsNyBAQCBpb21h
cF9kaW9fcncoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIsCiAJCQly
ZXR1cm4gLUVJT0NCUVVFVUVEOwogCiAJCWZvciAoOzspIHsKLQkJCV9fc2V0X2N1cnJlbnRfc3Rh
dGUoVEFTS19VTklOVEVSUlVQVElCTEUpOwotCisJCQlzZXRfY3VycmVudF9zdGF0ZShUQVNLX1VO
SU5URVJSVVBUSUJMRSk7CiAJCQlpZiAoIVJFQURfT05DRShkaW8tPnN1Ym1pdC53YWl0ZXIpKQog
CQkJCWJyZWFrOwogCmRpZmYgLS1naXQgYS9tbS9wYWdlX2lvLmMgYi9tbS9wYWdlX2lvLmMKaW5k
ZXggMzQ3NTczM2IxOTI2Li5kOTc1ZmEzZjAyYWEgMTAwNjQ0Ci0tLSBhL21tL3BhZ2VfaW8uYwor
KysgYi9tbS9wYWdlX2lvLmMKQEAgLTQwNSw4ICs0MDUsNyBAQCBpbnQgc3dhcF9yZWFkcGFnZShz
dHJ1Y3QgcGFnZSAqcGFnZSwgYm9vbCBzeW5jaHJvbm91cykKIAliaW9fZ2V0KGJpbyk7CiAJcWMg
PSBzdWJtaXRfYmlvKGJpbyk7CiAJd2hpbGUgKHN5bmNocm9ub3VzKSB7Ci0JCV9fc2V0X2N1cnJl
bnRfc3RhdGUoVEFTS19VTklOVEVSUlVQVElCTEUpOwotCisJCXNldF9jdXJyZW50X3N0YXRlKFRB
U0tfVU5JTlRFUlJVUFRJQkxFKTsKIAkJaWYgKCFSRUFEX09OQ0UoYmlvLT5iaV9wcml2YXRlKSkK
IAkJCWJyZWFrOwogCg==
--0000000000007e3461057e7e3053--
