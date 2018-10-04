Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1538665857.230807.1.camel@acm.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
From: Bart Van Assche <bvanassche@acm.org>
To: Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>, Jens
 Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>, linux-mtd@lists.infradead.org, Pavel
 Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>, Richard
 Weinberger <richard@nod.at>, Artem Bityutskiy <dedekind1@gmail.com>, Adrian
 Hunter <adrian.hunter@intel.com>, Jan Kara <jack@suse.cz>,
 aherrmann@suse.com,  mgorman@suse.com, Chunyan Zhang
 <zhang.chunyan@linaro.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, bfq-iosched@googlegroups.com
Date: Thu, 04 Oct 2018 08:10:57 -0700
In-Reply-To: <20181004101305.GA6412@sirena.org.uk>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
	 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
	 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
	 <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
	 <CACRpkdYG2Y=rspbZ_o=H3REXTEfOcaiqEyQD4kzO=G=d63V3yA@mail.gmail.com>
	 <20181004101305.GA6412@sirena.org.uk>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-10-04 at 11:13 +-0100, Mark Brown wrote:
+AD4 On Thu, Oct 04, 2018 at 10:14:38AM +-0200, Linus Walleij wrote:
+AD4 
+AD4 +AD4 And these are millions and millions of deployed
+AD4 +AD4 systems not using udev+-systemd we are talking about,
+AD4 +AD4 they are not fringe hobby projects. It's not that I
+AD4 +AD4 personally dislike udev or anything, I kind of like
+AD4 +AD4 it, but these tailored distros simply don't use it
+AD4 +AD4 and they are huge in numbers. They need help to do
+AD4 +AD4 the right thing. Fixing a udev rule doesn't solve
+AD4 +AD4 even half the world's problems I'm afraid.
+AD4 
+AD4 Further, even those embedded systems that do use udev (some of them do
+AD4 lean heavily on modern init stuff like that and systemd, especially when
+AD4 boot time is a priority) they'll still need to get the relevant udev
+AD4 rule installed somehow.

Hi Mark,

Are you aware that the systemd source tree includes a set of udev rules?
See also https://github.com/systemd/systemd/tree/master/rules.

Bart.
