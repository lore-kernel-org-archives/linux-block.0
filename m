Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4DFC4151A
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 16:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CEE21920
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 16:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCq+d/Oz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfBGQ6o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:58:44 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40733 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfBGQ6n (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 11:58:43 -0500
Received: by mail-qt1-f193.google.com with SMTP id j36so624348qta.7
        for <linux-block@vger.kernel.org>; Thu, 07 Feb 2019 08:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tGS+/06TiNKR/0AwMCNv7SAY8WZTxjjr0AM7Q3DY3TU=;
        b=pCq+d/OzE2rcu87S060ZiT9VywBi/7zrdYWYUt/77vAUezP+LUWR+6XcW548Zi6JVp
         XqOnUsOnQHAbnpQG/rC2PPCNN3nkw6EjhBfnizXTiigsLfgy6j43Z6245eqZ2JpjdSer
         PYr3Ncgw9l0WbEu6UKJF8h0m7iaJxlhAGJBR8xa/6kbZiEeTAAH0mg+boL4ufZR+6VtO
         f9tGwbAJ04Ai0KHWMQ8WxTjx7Tg7TU5XKt3XylrcgXUqM8t75j+fCEAE4tfJM2K8xPeW
         zwqzcSrCcmbbuU/jbcnt4shohMALFFHZfpGnrtS2I49aVMBHpdSwgLH+mpjPguRY5kHg
         IeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=tGS+/06TiNKR/0AwMCNv7SAY8WZTxjjr0AM7Q3DY3TU=;
        b=t90xqJmZSyJENv7Dey4TvrRdaPymZH8ogxN6bMOvDFtRgAZy36hXcPrn7dAMg1w4FJ
         49/i0CsI3oN/bo1cUm4ukxB4DVbSw4TyipI50CPD0/GqAI3wHXPT48VhHaBhoQ75ZNul
         lidLqNScpIfToPHrRuiyvm3VKMgGkStQAJJq7eEPKt8x46XAoR2Udg1Yf9H+xVP3NwLB
         4LJg/WeRqrphkhYO5A9NW8o+Og/9JNlUiDByvB2+oEhxvceya07SwdVgNJajLyrbCVb1
         wukYHm5uxrT3QpgQBCJvMTt1ecmVmu3WbVVY7VjBVJhL2ARtr47DzX72XRmWyLMvIFVy
         HmDw==
X-Gm-Message-State: AHQUAuacPn0KjCs7eIXf0CJATPqwU6cZhZOo23H3p2ly24VRR8JacwfB
        uRm3096E6S4kDGd0GYs6c7I=
X-Google-Smtp-Source: AHgI3IYReDMx8yRD4U0jQAqw1I13+HNF75bl7p5O0nxr05XORBdnRjgW383XmGKeF0wNxl3aCf2aig==
X-Received: by 2002:aed:3b92:: with SMTP id r18mr4071282qte.7.1549558722552;
        Thu, 07 Feb 2019 08:58:42 -0800 (PST)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t10sm8492541qtt.63.2019.02.07.08.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 08:58:41 -0800 (PST)
Date:   Thu, 7 Feb 2019 11:58:40 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: [git pull] device mapper fixes for 5.0-rc6
Message-ID: <20190207165840.GA62096@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Both of these fixes address issues in changes merged for 5.0-rc4.

The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:

  Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.0/dm-fixes-2

for you to fetch changes up to fa8db4948f5224dae33a0e783e7dec682e145f88:

  dm: don't use bio_trim() afterall (2019-02-06 17:24:37 -0500)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix DM core's missing memory barrier before waitqueue_active() calls.

- Fix DM core's clone_bio() to work when cloning a subset of a bio with
  an integrity payload; bio_integrity_trim() wasn't getting called due
  to bio_trim()'s early return.

----------------------------------------------------------------
Mike Snitzer (1):
      dm: don't use bio_trim() afterall

Mikulas Patocka (1):
      dm: add memory barrier before waitqueue_active

 drivers/md/dm-rq.c | 2 +-
 drivers/md/dm.c    | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)
