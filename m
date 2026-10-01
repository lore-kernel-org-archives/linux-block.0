Received: from mail-oo2-f36.google.com (mail-oo2-f36.google.com [74.125.231.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C20E451996
	for <linux-block@vger.kernel.org>; Thu,  1 Oct 2026 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859272; cv=none; b=sCD2v/r/yxvLwWdrlUB9LLDcaGvPrUmW9wY3P+WdmPo5tGzvfeAcCT4zq7oG2KFbzc60FBzdCFUIqH4BV4Z/aBJ2QifRJ1/OpAjCGUZNWKGxAcwAq9a595ufv9aGgbhtF3+HTqRytqAJV1uRSsoAADCVpj3eUjERFArEX8IieDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859272; c=relaxed/simple;
	bh=Rgy088/EK8kZEDm64WUQ84PSIhACJdiDcJMT+wDUDCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uiFMwZYqzDS8c9ND3Qyw7pHJoIVmDK+vdRdKQm1KvOJUrbYi6/mZL0aoq4FSUa/j553hiqTpUhnfkWrP6Xan/4WvrWqjRM6TSTZrOGGwg5/WAb0sDAWlOAnowroHGR0elVil9VP6iCQhdkx1U4K/fxCc4dtH1YhZfTVIkOeUtJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZX3yaVc; arc=none smtp.client-ip=74.125.231.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZX3yaVc"
Received: by mail-oo2-f36.google.com with SMTP id 46e09a7af769-81a8d9a166fso2779344a34.3
        for <linux-block@vger.kernel.org>; Thu, 01 Oct 2026 05:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790859269; x=1791464069; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jvM+aLvqEMxkhpBvOVv3KOJ2j2bYwsNiBE9HJ51sIEI=;
        b=HZX3yaVcpYSyYm7lvAEwhyTJag0SscfmQS495y+owlUGbLgCv2HHrGUvK6e8wN9FmE
         fYcFLzSriCouuOhvvvqqY9NdwuhBo3yp/icDtJKOSnRzdu+TO04GN2+QXbvYEqgmRwfO
         7HVOMpu71frZhMoWljIP1KquWExUcM+fH55E/zNqiAwLAwWsrpys9N71KC/CvyO4AcVN
         kVXEZ7zWXoPTovZ/J1PckqQ0kcGkeKs7M0XGO+f2IZl/xEar6RuiZxspAWGL0Nf9pjA0
         XFEcpDpLg6MxYqiMD25w41W3fBYhI/XnDipbm9y8mVXVzkcrZbrioTLww8Fe4kNDulnK
         FStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790859269; x=1791464069;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jvM+aLvqEMxkhpBvOVv3KOJ2j2bYwsNiBE9HJ51sIEI=;
        b=l2Tac6Ul/0LBppeiQ4vAsW5igim5eHs37xLuhQqlMgql91pCwoADKnTue6UOF9ltNn
         f/Az3ry+RHxA3MpvbXjP/cHTUJZgPjz75XkrmTmQkMHgn9wRGyE64W5MawxB0l1csYJo
         aufttKHPq5LQ/UvV3mZMr1fvX0ky01N6/6xaA37ei9a+X9+JFUM6XZeS59slvzVEkGT7
         heHilsFIgtP+2HBI9ma0sGzt3m5d1az9simbBje8Ii/ij8GfLNzNtlvr8yIJSzoT804W
         1Xl5Vrz4qSJKa3MhnwtMOzUXXs3Bhy8n180fhAArNasxAl/QkfJbE52rRteeupVThF28
         0aIQ==
X-Gm-Message-State: AFuF++ly9Un3I8x4Ox/2LRL6UbY7X/OfSHRgF1oZ0XDiMNPbT1n7Dt54
	lkI95uR9kkIgAn8iUSKqGexa33Z9fWeYSV+X+pgfOSpfq2FuTPnebuz0q5f3vw==
X-Gm-Gg: AYBFou00Ps+id5kwuaTj7rCwfoNJRlpM51to88ReQHOFcpwpTPxssf/2Uf+KRBxtt+9
	7usdnBH06uGPwjFpp6G2JIVX7n6wxJm+qQrc1d6jbfim83i9AZuB7gmlLP/RrYSosnokSz6Qy0S
	6oDtnWxMsLFa+exNWLqd55LsrdIQwuI83tSETjDrgD3QKpdI4+V4p7B8S3G2lAKSSD46ZPNlP53
	sUh8X+4tIII5kFoRIJpw1I9z8rsg8THsgCJ+LwU+f++AG8AYRbLzZ87n0MoSIQhiGcQ4nUUfBJe
	t3RTWgIkIl6wWE+LjpdzQPPWBTVPiBDeGCwr3Q73MQB5RXDf3DCtXLuEB72KwGrwoVRPKel9mgi
	T58mLdxZP8sNYFX8yYPj1kPScXH90W7p2F4RUIaJitFLgTizm1ByZ0o18pAlBtFwpdOGtr22A3O
	YyXBWLjwm3acF5x1GN2jUfx2fE0OmTHhlZjVVsJlucFoGi41CJoSVJViiLnyDAgdDUar5m4u69o
	o/xXVkauzfwB0/nW1nQW/PdC8IQeWI/bvLWXheSd9p3ekfbDntBczbN45jh9p82zEpqiRsa7UYO
	5JrJAjODRPu1u16JNUTHEw/qjfY=
X-Received: by 2002:a05:6830:2b06:b0:80c:d34f:5f66 with SMTP id 46e09a7af769-8204ad6f917mr5723810a34.31.1790859268597;
        Thu, 01 Oct 2026 05:54:28 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212b937bf2sm2504806a34.27.2026.10.01.05.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 05:54:28 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 0/8] ublk: don't dispatch to canceled io commands
Date: Thu,  1 Oct 2026 07:54:14 -0500
Message-ID: <20261001125422.1364260-1-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Josef reported three ways in which ublk dispatches a request to a
canceled io command, which oopses on the NULL io->cmd in
ublk_queue_cmd() [1]:

1) STOP_DEV, then START_DEV
2) partial FETCH: a task fetches some tags and exits, then another task
   fetches the rest
3) user recovery: one queue's task exits before all queues are ready

This series fixes them in a simpler way, without extra locking in the
I/O path:

- patch 1: a FETCH round which saw a cancel stays canceling until the
  server is gone (2, 3)
- patch 2-3: an io command is marked cancelable before it is published
- patch 4-6: the release resets the FETCH round, also without a disk
  and under ub->mutex; STOP_DEV holds a reference on /dev/ublkcN while
  it cancels, so no START_DEV, FETCH or new server can slip in (1)
- patch 7-8: selftest

Tested with all ublk selftests, plus KASAN and lockdep.

[1] https://lore.kernel.org/linux-block/20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com/

Thanks,
Ming

Ming Lei (8):
  ublk: keep a canceled FETCH round canceling until the server is gone
  ublk: mark the io command cancelable before publishing it
  ublk: mark the batch fetch command cancelable before linking it
  ublk: reset the FETCH round in release also without a disk
  ublk: reset the FETCH round under ub->mutex
  ublk: let STOP_DEV cancel the server's commands before its release
  selftests: ublk: move the control command helpers into ctrl.c
  selftests: ublk: add test for going live over canceled io commands

 drivers/block/ublk_drv.c                      | 206 +++-
 tools/testing/selftests/ublk/.gitignore       |   1 +
 tools/testing/selftests/ublk/Makefile         |   6 +-
 tools/testing/selftests/ublk/ctrl.c           | 268 +++++
 tools/testing/selftests/ublk/kublk.c          | 271 -----
 tools/testing/selftests/ublk/kublk.h          |  32 +
 .../testing/selftests/ublk/test_generic_18.sh |  37 +
 .../selftests/ublk/ublk_cancel_ready.c        | 984 ++++++++++++++++++
 8 files changed, 1484 insertions(+), 321 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/ctrl.c
 create mode 100755 tools/testing/selftests/ublk/test_generic_18.sh
 create mode 100644 tools/testing/selftests/ublk/ublk_cancel_ready.c

-- 
2.55.0

