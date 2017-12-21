Return-Path: <bruno@wolff.to>
Date: Thu, 21 Dec 2017 07:00:57 -0600
From: Bruno Wolff III <bruno@wolff.to>
To: Laura Abbott <labbott@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
  regressions@leemhuis.info, weiping zhang <zhangweiping@didichuxing.com>,
  linux-block@vger.kernel.org
Subject: Re: Regression with a0747a859ef6 ("bdi: add error handle for
 bdi_debug_register")
Message-ID: <20171221130057.GA26743@wolff.to>
References: <b1415a6d-fccd-31d0-ffa2-9b54fa699692@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <b1415a6d-fccd-31d0-ffa2-9b54fa699692@redhat.com>
List-ID: <linux-block@vger.kernel.org>

After today, I won't have physical access to the problem machine until 
January 2nd. So if you guys have any testing suggestions I need them soon 
if they are to get done before my vacation.
I do plan to try booting to level 1 to see if I can get a login prompt 
that might facilitate testing. The lockups do happen fairly late in the 
boot process. I never get to X, but maybe it will get far enough for 
a console login.
