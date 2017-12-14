Return-Path: <bruno@wolff.to>
Date: Thu, 14 Dec 2017 02:24:52 -0600
From: Bruno Wolff III <bruno@wolff.to>
To: Laura Abbott <labbott@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
  regressions@leemhuis.info, weiping zhang <zhangweiping@didichuxing.com>,
  linux-block@vger.kernel.org
Subject: Re: Regression with a0747a859ef6 ("bdi: add error handle for
 bdi_debug_register")
Message-ID: <20171214082452.GA16698@wolff.to>
References: <b1415a6d-fccd-31d0-ffa2-9b54fa699692@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <b1415a6d-fccd-31d0-ffa2-9b54fa699692@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Dec 13, 2017 at 16:54:17 -0800,
  Laura Abbott <labbott@redhat.com> wrote:
>Hi,
>
>Fedora got a bug report https://bugzilla.redhat.com/show_bug.cgi?id=1520982
>of a boot failure/bug on Linus' master (full bootlog at the bugzilla)

I'm available for testing. The problem happens on my x86_64 Dell Workstation, 
but not an old i386 server or an x86_64 mac hardware based laptop.
