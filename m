Return-Path: <mlyle@lyle.org>
Return-Path: <mlyle@lyle.org>
From: Michael Lyle <mlyle@lyle.org>
To: linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: axboe@kernel.dk
Subject: Commits for 4.15-- bcache
Date: Fri, 24 Nov 2017 15:14:23 -0800
Message-Id: <20171124231427.9563-1-mlyle@lyle.org>
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

We have a few more small things:

Huacai Chen (1):
      bcache: Fix building error on MIPS

Michael Lyle (1):
      bcache: check return value of register_shrinker

Rui Hua (1):
      bcache: recover data from backing when data is clean

Tang Junhui (1):
      bcache: add a comment in journal bucket reading

Most important is Rui Hua's change, which prevents EINTR from being
returned to users unexpectedly (and is cc'd stable).  All changes are
reviewed and have had a moderate degree of test.

Thanks,

Mike
