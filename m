Return-Path: <mathieu.poirier@linaro.org>
MIME-Version: 1.0
In-Reply-To: <e959f23d6f6905ee606fadfda13e2bb37deed017.1525870886.git.mchehab+samsung@kernel.org>
References: <cover.1525870886.git.mchehab+samsung@kernel.org> <e959f23d6f6905ee606fadfda13e2bb37deed017.1525870886.git.mchehab+samsung@kernel.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 16 May 2018 09:12:56 -0600
Message-ID: <CANLsYkwXUGJ-DM4M48SXuy+31r6sC7_Q3fc9Rgue6wFdeMQv6g@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] docs: Fix some broken references
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>,
	Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Harry Wei <harryxiyou@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, Michal Simek <monstr@monstr.eu>, Jeff Dike <jdike@addtoit.com>,
	Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@linux.ie>,
	Gustavo Padovan <gustavo@padovan.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sean Paul <seanpaul@chromium.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
	Matias Bjorling <mb@lightnvm.io>, Michael Lyle <mlyle@lyle.org>,
	Kent Overstreet <kent.overstreet@gmail.com>, Malcolm Priestley <tvboxspy@gmail.com>,
	Antoine Jacquet <royale@zerezo.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>, Li Zefan <lizefan@huawei.com>, Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>,
	Akira Yokosawa <akiyks@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@zh-kernel.org,
	user-mode-linux-devel@lists.sourceforge.net,
	user-mode-linux-user@lists.sourceforge.net, linux-xtensa@linux-xtensa.org,
	linux-block@vger.kernel.org, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-clk@vger.kernel.org,
	dri-devel@lists.freedesktop.org, patches@opensource.cirrus.com,
	linux-bcache@vger.kernel.org, linux-usb@vger.kernel.org,
	devel@driverdev.osuosl.org, xen-devel@lists.xenproject.org,
	cgroups@vger.kernel.org, selinux@tycho.nsa.gov,
	linux-security-module@vger.kernel.org, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On 9 May 2018 at 07:18, Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
> As we move stuff around, some doc references are broken. Fix some of
> them via this script:
>         ./scripts/documentation-file-ref-check --fix-rst
>
> Manually checked if the produced result is valid, removing a few
> false-positives.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---

>
> diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
> index 1d74ad0202b6..efbc832146e7 100644
> --- a/Documentation/trace/coresight.txt
> +++ b/Documentation/trace/coresight.txt
> @@ -426,5 +426,5 @@ root@genericarmv8:~#
>  Details on how to use the generic STM API can be found here [2].
>
>  [1]. Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
> -[2]. Documentation/trace/stm.txt
> +[2]. Documentation/trace/stm.rst
>  [3]. https://github.com/Linaro/perf-opencsd

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
