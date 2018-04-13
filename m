Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com
Subject: [PATCHSET 0/2] loop: dio fixup
Date: Fri, 13 Apr 2018 16:30:34 -0600
Message-Id: <1523658636-2212-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Wanted to do a v2 of the loop dio short read fix, since I figured
we should retain the zero fill for if we have to give up doing
reads. Also noticed that we have cmd->rq for some reason, so
killed that off as a cleanup.

-- 
Jens Axboe
