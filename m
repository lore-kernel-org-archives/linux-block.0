Return-Path: <mlyle@lyle.org>
Return-Path: <mlyle@lyle.org>
From: Michael Lyle <mlyle@lyle.org>
To: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org
Cc: axboe@kernel.dk
Subject: [PATCH 0/2] Duplicate UUID fixes for 4.16
Date: Mon,  5 Mar 2018 13:41:53 -0800
Message-Id: <20180305214155.23395-1-mlyle@lyle.org>
List-ID: <linux-block@vger.kernel.org>

Jens--

Sorry for a couple of last-minute changes.  Marc Merlin noticed an issue
with disk imaging where if multiple devices were present with the same
bcache UUID that a kernel panic could result.  Tang Junhui fixed this.
I found a related data corruption issue with duplicate backing devices.

Both are minimal, reviewed, and tested.  As always, thanks for your help.

Mike
