Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v5 1/2] Return bytes transferred for partial direct I/O
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "ak@linux.intel.com" <ak@linux.intel.com>,
 "rgoldwyn@suse.de" <rgoldwyn@suse.de>, "elliott@hpe.com" <elliott@hpe.com>
Cc: "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "RGoldwyn@suse.com" <RGoldwyn@suse.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20180119005741.32058-1-rgoldwyn@suse.de>
 <87zi58rmf7.fsf@linux.intel.com>
 <c7661c89-1deb-c967-4b19-c1897937f4a3@suse.de>
 <b6847555-6295-0f28-08f2-ad871bf91332@kernel.dk>
 <AT5PR8401MB0387219C83BE490226AB427FABEC0@AT5PR8401MB0387.NAMPRD84.PROD.OUTLOOK.COM>
 <7c4db194-7693-7c62-0eb3-db7eb90d1184@kernel.dk>
 <1516663459.2545.46.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f1842120-7e70-5e39-eb95-f11555789867@kernel.dk>
Date: Mon, 22 Jan 2018 16:27:09 -0700
MIME-Version: 1.0
In-Reply-To: <1516663459.2545.46.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/22/18 4:24 PM, Bart Van Assche wrote:
> On Mon, 2018-01-22 at 16:14 -0700, Jens Axboe wrote:
>> On 1/22/18 3:25 PM, Elliott, Robert (Persistent Memory) wrote:
>>> fio engines/sg.c fio_sgio_rw_doio() has that pattern:
>>>
>>> 	ret = write(f->fd, hdr, sizeof(*hdr));
>>> 	if (ret < 0)
>>> 		return ret;
>>> 	...
>>> 	return FIO_Q_QUEUED;   [which is 1]
>>>
>>> although there might be special circumstances for the sg interface
>>> making that safe.
>>
>> That's for SG scsi direct IO, I don't think that supports partial
>> IO since it's sending raw SCSI commands.
>>
>> For the regular libaio or sync IO system calls, fio of course checks
>> and handles short IOs correctly. It even logs if it got any.
> 
> The entire fio_sgio_rw_doio() function is as follows:
> 
> static int fio_sgio_rw_doio(struct fio_file *f, struct io_u *io_u, int do_sync)
> {
> 	struct sg_io_hdr *hdr = &io_u->hdr;
> 	int ret;
> 
> 	ret = write(f->fd, hdr, sizeof(*hdr));
> 	if (ret < 0)
> 		return ret;
> 
> 	if (do_sync) {
> 		ret = read(f->fd, hdr, sizeof(*hdr));
> 		if (ret < 0)
> 			return ret;
> 
> 		/* record if an io error occurred */
> 		if (hdr->info & SG_INFO_CHECK)
> 			io_u->error = EIO;
> 
> 		return FIO_Q_COMPLETED;
> 	}
> 
> 	return FIO_Q_QUEUED;
> }
> 
> I think the 'resid' member of the struct sg_io_hdr that is provided by the
> sg_io kernel driver as a response represents the number of bytes that has not
> been written. So it should be possible to recognize and handle short I/Os in
> that function. From include/scsi/sg.h:
> 
>     int resid;                  /* [o] dxfer_len - actual_transferred */

Yeah that's true.

But let's not side track the discussion here, fio+sg isn't relevant to the
topic at hand. Fio and other engines would be (like libaio, or sync and
friends), but those handle short/partial IOs just fine.

That said, if someone wants to submit a patch for the sg engine, I would
of course take it.

-- 
Jens Axboe
