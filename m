Return-Path: <prvs=80731d7bfe=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <jbacik@fb.com>
Subject: [PATCH 0/2]: Add option for async ->queue_rq
Date: Thu, 22 Sep 2016 08:52:58 -0600
Message-ID: <1474555980-2787-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Two patches that add the ability for a driver to flag itself
as wanting the ->queue_rq() invoked in a manner that allows
it to block. We'll need that for the nbd conversion, to avoid
having to add workqueue offload. We can use this in the current
loop mq path as well.
