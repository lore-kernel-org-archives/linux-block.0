Return-Path: <hch@lst.de>
Date: Mon, 9 Apr 2018 11:35:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Kees Cook <keescook@chromium.org>, David Windsor <dave@nullcore.net>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-block@vger.kernel.org, paolo.valente@linaro.org
Subject: Re: usercopy whitelist woe in scsi_sense_cache
Message-ID: <20180409093520.GB10405@lst.de>
References: <10360653.ov98egbaqx@natalenko.name> <CAGXu5jL8oLV2xvjBVYv_SNXr74LdgpXEmU7K+cLYpD7jh2chgw@mail.gmail.com> <CAGXu5j+mVc6O_=GOF3YQmS4QZxeFgVPQtMxNH8sjBAhpJLjm9w@mail.gmail.com> <2679696.GDoj5zcZOu@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2679696.GDoj5zcZOu@natalenko.name>
List-ID: <linux-block@vger.kernel.org>

I really can't make sense of that report.  And I'm also curious why
you think 17cb960f29c2 should change anything for that code path.
