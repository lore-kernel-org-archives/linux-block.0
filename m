Return-Path: <stern+5af46fa8@rowland.harvard.edu>
Date: Wed, 9 May 2018 15:11:07 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
cc: Andrea Parri <parri.andrea@gmail.com>,
    Linux Doc Mailing List <linux-doc@vger.kernel.org>,
    Mauro Carvalho Chehab <mchehab@infradead.org>,
     <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
    Dmitry Torokhov <dmitry.torokhov@gmail.com>,
    Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
    Linus Walleij <linus.walleij@linaro.org>,
    Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
    Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
    "David S. Miller" <davem@davemloft.net>,
    Masami Hiramatsu <mhiramat@kernel.org>,
    Mathieu Poirier <mathieu.poirier@linaro.org>,
    Alexander Shishkin <alexander.shishkin@linux.intel.com>,
    Harry Wei <harryxiyou@gmail.com>, Russell King <linux@armlinux.org.uk>,
    Catalin Marinas <catalin.marinas@arm.com>,
    Will Deacon <will.deacon@arm.com>, Michal Simek <monstr@monstr.eu>,
    Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
    Guan Xuetao <gxt@pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>,
    Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
     <x86@kernel.org>, Chris Zankel <chris@zankel.net>,
    Max Filippov <jcmvbkbc@gmail.com>, Jens Axboe <axboe@kernel.dk>,
    David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
    Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Michael Turquette <mturquette@baylibre.com>,
    Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@linux.ie>,
    Gustavo Padovan <gustavo@padovan.org>,
    Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
    Sean Paul <seanpaul@chromium.org>,
    Pali =?UTF-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>,
    Matias Bjorling <mb@lightnvm.io>, Michael Lyle <mlyle@lyle.org>,
    Kent Overstreet <kent.overstreet@gmail.com>,
    Malcolm Priestley <tvboxspy@gmail.com>,
    Antoine Jacquet <royale@zerezo.com>,
    Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
    Steven Rostedt <rostedt@goodmis.org>,
    "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
    Josh Triplett <josh@joshtriplett.org>,
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
    Lai Jiangshan <jiangshanlai@gmail.com>,
    Boris Ostrovsky <boris.ostrovsky@oracle.com>,
    Juergen Gross <jgross@suse.com>, Li Zefan <lizefan@huawei.com>,
    Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
    Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>, Jaroslav Kysela <perex@perex.cz>,
    Takashi Iwai <tiwai@suse.com>, Peter Zijlstra <peterz@infradead.org>,
    Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
    Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>,
    Akira Yokosawa <akiyks@gmail.com>,
    Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
    Namhyung Kim <namhyung@kernel.org>,  <linux-input@vger.kernel.org>,
     <devicetree@vger.kernel.org>,  <linux-gpio@vger.kernel.org>,
     <linux-arm-kernel@lists.infradead.org>,  <linux-kernel@zh-kernel.org>,
     <user-mode-linux-devel@lists.sourceforge.net>,
     <user-mode-linux-user@lists.sourceforge.net>,
     <linux-xtensa@linux-xtensa.org>,  <linux-block@vger.kernel.org>,
     <keyrings@vger.kernel.org>,  <linux-crypto@vger.kernel.org>,
     <linux-clk@vger.kernel.org>,  <dri-devel@lists.freedesktop.org>,
     <patches@opensource.cirrus.com>,  <linux-bcache@vger.kernel.org>,
     <linux-usb@vger.kernel.org>,  <devel@driverdev.osuosl.org>,
     <xen-devel@lists.xenproject.org>,  <cgroups@vger.kernel.org>,
     <selinux@tycho.nsa.gov>,  <linux-security-module@vger.kernel.org>,
     <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v2 09/11] docs: Fix some broken references
In-Reply-To: <20180509152045.722f0c51@vento.lan>
Message-ID: <Pine.LNX.4.44L0.1805091509100.1391-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Wed, 9 May 2018, Mauro Carvalho Chehab wrote:

> Em Wed, 9 May 2018 19:15:01 +0200
> Andrea Parri <parri.andrea@gmail.com> escreveu:

> > >  tools/memory-model/README                     | 10 +++++-----  
> > 
> > As mentioned in the previous thread, I am for keeping the current
> > references: the REAMDE is listing the doc files, as well as other
> > files in tools/memory-model/, relatively to that directory.
> 
> Yeah, at least this hunk deserves some rework, as now some
> references are Documentation/.../foo, while others are just
> bar.
> 
> As on (almost) all other places (except for tools/memory-model/README),
> the references are always from the main directory, I would make all
> patches there also relative to main dir. If you're afraid of
> not being too clearer, we could prefix all of them with something
> like:
> 
> 	${LINUX}/tools/memory-model/...
> 
> just like some DT binding files do:
> 
> 	Documentation/devicetree/bindings/sound/audio-graph-card.txt:see ${LINUX}/Documentation/devicetree/bindings/graph.txt
> 
> A bonus of doing that is that the broken reference detect script can
> keep parsing it without changes (well, it wouldn't be hard to make
> it also accept a relative file, but doing that just due to 
> tools/memory-model/README seems overkill).
> 
> Another advantage is that it would allow to easily add references
> there from the main kernel Documentation, if needed in the future,
> without messing with local x non-local relative namespace.

How about changing the relative references so that something like
Documentation/recipes.txt becomes ./Documentation/recipes.txt?

Alan Stern
