Return-Path: <bruno@wolff.to>
Date: Thu, 14 Dec 2017 04:29:30 -0600
From: Bruno Wolff III <bruno@wolff.to>
To: Laura Abbott <labbott@redhat.com>, Jan Kara <jack@suse.cz>,
  Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
  regressions@leemhuis.info, linux-block@vger.kernel.org
Subject: Re: Regression with a0747a859ef6 ("bdi: add error handle for
 bdi_debug_register")
Message-ID: <20171214102930.GA24997@wolff.to>
References: <b1415a6d-fccd-31d0-ffa2-9b54fa699692@redhat.com>
 <20171214082452.GA16698@wolff.to>
 <20171214100927.GA26167@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <20171214100927.GA26167@localhost.didichuxing.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Dec 14, 2017 at 18:09:27 +0800,
  weiping zhang <zhangweiping@didichuxing.com> wrote:
>On Thu, Dec 14, 2017 at 02:24:52AM -0600, Bruno Wolff III wrote:
>> On Wed, Dec 13, 2017 at 16:54:17 -0800,
>>  Laura Abbott <labbott@redhat.com> wrote:
>> >Hi,
>> >
>> >Fedora got a bug report https://bugzilla.redhat.com/show_bug.cgi?id=1520982
>> >of a boot failure/bug on Linus' master (full bootlog at the bugzilla)
>>
>> I'm available for testing. The problem happens on my x86_64 Dell
>> Workstation, but not an old i386 server or an x86_64 mac hardware
>> based laptop.
>
>Hi,
>
>It seems something wrong with bdi debugfs register, could you help
>test the forllowing debug patch, I add some debug log, no function
>change, thanks.

I'll test it this morning. I'll probably have results in about 7 hrs from now.
