Return-Path: <bruno@wolff.to>
Date: Tue, 19 Dec 2017 13:48:35 -0600
From: Bruno Wolff III <bruno@wolff.to>
To: Shaohua Li <shli@kernel.org>
Cc: weiping zhang <zwp10758@gmail.com>, Laura Abbott <labbott@redhat.com>,
  Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
  regressions@leemhuis.info, linux-block@vger.kernel.org
Subject: Re: Regression with a0747a859ef6 ("bdi: add error handle for
 bdi_debug_register")
Message-ID: <20171219194835.GA5571@wolff.to>
References: <CAA70yB6yofLz8pfhxXfq29sYqcGmBYLOvSruXi9XS_HM6mUrxg@mail.gmail.com>
 <20171215014417.GA17757@wolff.to>
 <CAA70yB6spi5c38kFVidRsJVaYc3W9tvpZz6wy+28rK7oeefQfw@mail.gmail.com>
 <20171215111050.GA30737@wolff.to>
 <CAA70yB66ekUGAvusQbqo7BLV+uBJtNz72cr+tZitsfjuVRWuXA@mail.gmail.com>
 <20171215195122.GA27126@wolff.to>
 <20171216163226.GA1796@wolff.to>
 <CAA70yB7wL_Wq5S8XQ9zHuLPDdwepv7dYdKALL8Sg0q6CNdAz5g@mail.gmail.com>
 <20171219161743.GA6960@wolff.to>
 <20171219182452.vpmqpi3yb4g2ecad@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <20171219182452.vpmqpi3yb4g2ecad@kernel.org>
List-ID: <linux-block@vger.kernel.org>

On Tue, Dec 19, 2017 at 10:24:52 -0800,
  Shaohua Li <shli@kernel.org> wrote:
>
>Not sure if this is MD related, but could you please check if this debug patch
>changes anything?

I'm doing a build now. I do use md to mirror disk partitions between two disks. I do that on another machine that doesn't exhibit the problem, but it is 
i686, not x86_64.
