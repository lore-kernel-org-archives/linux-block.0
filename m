Return-Path: <bruno@wolff.to>
Date: Fri, 29 Dec 2017 12:44:55 -0600
From: Bruno Wolff III <bruno@wolff.to>
To: Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@kernel.dk>,
  Laura Abbott <labbott@redhat.com>, Jan Kara <jack@suse.cz>,
  James Bottomley <James.Bottomley@HansenPartnership.com>,
  weiping zhang <zwp10758@gmail.com>, linux-mm@kvack.org,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
  regressions@leemhuis.info, linux-block@vger.kernel.org
Subject: Re: Regression with a0747a859ef6 ("bdi: add error handle for
 bdi_debug_register")
Message-ID: <20171229184455.GA30054@wolff.to>
References: <20171221153631.GA2300@wolff.to>
 <CAA70yB6nD7CiDZUpVPy7cGhi7ooQ5SPkrcXPDKqSYD2ezLrGHA@mail.gmail.com>
 <20171221164221.GA23680@wolff.to>
 <14f04d43-728a-953f-e07c-e7f9d5e3392d@kernel.dk>
 <20171221181531.GA21050@wolff.to>
 <20171221231603.GA15702@wolff.to>
 <20171222045318.GA4505@wolff.to>
 <CAA70yB5y1uLvtvEFLsE2C_ALLvSqEZ6XKA=zoPeSaH_eSAVL4w@mail.gmail.com>
 <20171222140423.GA23107@wolff.to>
 <20171229163021.GA9150@bogon.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <20171229163021.GA9150@bogon.didichuxing.com>
List-ID: <linux-block@vger.kernel.org>

On Sat, Dec 30, 2017 at 00:30:32 +0800,
  weiping zhang <zhangweiping@didichuxing.com> wrote:
>1. Add proper SELINUX policy that give permission to mdadm for debugfs.
>2. Split mdadm into 2 part, Firstly, user proccess mdadm trigger a kwork,
>secondly kwork will create gendisk)and mdadm wait it done, Like
>following:
>
>diff --git a/drivers/md/md.c b/drivers/md/md.c

Is that patch ready to be tested?

Fedora hasn't built an rc5 kernel yet, probably because a lot of people 
are off work this week. So I haven't done that test yet.
