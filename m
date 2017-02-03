Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"snitzer@redhat.com" <snitzer@redhat.com>
CC: "agk@redhat.com" <agk@redhat.com>, "dm-devel@redhat.com"
	<dm-devel@redhat.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v3] dm: don't allow ioctls to targets that don't map to
 whole devices
Date: Fri, 3 Feb 2017 21:41:16 +0000
Message-ID: <1486158062.2553.12.camel@sandisk.com>
References: <20170203163708.13943-1-hch@lst.de>
	 <20170203163921.GA823@redhat.com> <20170203164129.GA4755@lst.de>
	 <4435311b-80e1-8764-fa12-140203e9231f@suse.de>
In-Reply-To: <4435311b-80e1-8764-fa12-140203e9231f@suse.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-02-03 at 19:17 +0100, Johannes Thumshirn wrote:
> Forgotten git add? git commit --amend without git add is such a classic=20
> mistake on my side as well :-/

Are you familiar with the -a option of git commit? Just run

git commit -a --amend

Bart.=
