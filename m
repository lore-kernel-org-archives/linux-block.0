Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Cc: jack@suse.cz, bart.vanassche@wdc.com, ming.lei@redhat.com,
        rjw@rjwysocki.net, mguzik@redhat.com, linux-pm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH 0/3] fs: minor fs thaw fixes and adjustments
Date: Fri, 20 Apr 2018 16:59:01 -0700
Message-Id: <20180420235904.27496-1-mcgrof@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Here's a few minor fs thaw fixes and adjustments I ran accross
as I started to refresh my development for to use freeze_fs on
suspend/hibernation [0]. These are just prep commits for the real
work, I'm still reviewing feedback and adjusting the code for
that.

I've tested the patches with generic/085 on xfs and found no regressions.

Luis R. Rodriguez (3):
  fs: move documentation for thaw_super() where appropriate
  fs: make thaw_super_locked() really just a helper
  fs: fix corner case race on freeze_bdev() when sb disappears

 fs/block_dev.c |  4 +++-
 fs/super.c     | 39 ++++++++++++++++++++++++++-------------
 2 files changed, 29 insertions(+), 14 deletions(-)

-- 
2.16.3
