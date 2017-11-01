Return-Path: <axboe@kernel.dk>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20171101014611.GA8200@ming.t460p>
Date: Tue, 31 Oct 2017 19:53:03 -0600
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Omar Sandoval <osandov@fb.com>,
 Bart Van Assche <bart.vanassche@sandisk.com>,
 Roman Pen <roman.penyaev@profitbricks.com>,
 Hannes Reinecke <hare@suse.com>
Message-Id: <59F9FE28-F31A-47FD-A3FD-90CE1DB38FB2@kernel.dk>
References: <20171027044330.11921-1-ming.lei@redhat.com> <7921fc66-16de-200b-cc0f-02cf52ef9002@kernel.dk> <20171101014611.GA8200@ming.t460p>
To: Ming Lei <ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>


> On Oct 31, 2017, at 7:46 PM, Ming Lei <ming.lei@redhat.com> wrote:
>=20
>> On Tue, Oct 31, 2017 at 02:29:32PM -0600, Jens Axboe wrote:
>>> On 10/26/2017 10:43 PM, Ming Lei wrote:
>>> Hi Jens,
>>>=20
>>> The 1st patch removes the RESTART for TAG-SHARED because SCSI handles it=

>>> by itself, and not necessary to waste CPU to do the expensive RESTART.
>>> And Roman Pen reported that this RESTART cuts half of IOPS in his case.
>>>=20
>>> The 2nd patch removes the RESTART when .get_budget returns BLK_STS_RESOU=
RCE,
>>> and this RESTART is handled by SCSI's RESTART(scsi_end_request()) too.
>>=20
>> What base is this against?
>=20
> The for-next branch of your block tree:

=46rom when? Doesn=E2=80=99t apply at all today.=20
