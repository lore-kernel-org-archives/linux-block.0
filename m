Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 0/3] iowatcher improvements
Date: Fri, 20 May 2016 13:54:56 +0200
Message-Id: <1463745299-5951-1-git-send-email-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>


Hi,

this patches implement some improvements in iowatcher I was looking for
for some time already. When analyzing more complex block traces, it is
sometimes useful to plot IO from different processes by different color.
However in some cases there are too many processes involved and you
cannot distinguish much anyway. In those cases you need more refined
coloring of the IO graph. Since the exact needs usually differ on case
by case basis, I have decided to implement a way in iowatcher to use
an external program for marking IO and then display the result
(differently marked IO in different colors). The idea is that the
external program can be written e.g. in Python where you can write a
quick & dirty script to mark the IO as you need.

In the series is also a sample python script that tags IO by originating
process (not distinguishing reads and writes) and allows grouping of
processes into groups displayed by the same color. It is pretty easy to
add your own scripts to color IO based on different metrics (e.g.
completion time).

								Honza
