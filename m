Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v5 1/2] Return bytes transferred for partial direct I/O
To: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>,
 Goldwyn Rodrigues <rgoldwyn@suse.de>, Andi Kleen <ak@linux.intel.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
 "Rodrigues, Goldwyn" <RGoldwyn@suse.com>
References: <20180119005741.32058-1-rgoldwyn@suse.de>
 <87zi58rmf7.fsf@linux.intel.com>
 <c7661c89-1deb-c967-4b19-c1897937f4a3@suse.de>
 <b6847555-6295-0f28-08f2-ad871bf91332@kernel.dk>
 <AT5PR8401MB0387219C83BE490226AB427FABEC0@AT5PR8401MB0387.NAMPRD84.PROD.OUTLOOK.COM>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7c4db194-7693-7c62-0eb3-db7eb90d1184@kernel.dk>
Date: Mon, 22 Jan 2018 16:14:47 -0700
MIME-Version: 1.0
In-Reply-To: <AT5PR8401MB0387219C83BE490226AB427FABEC0@AT5PR8401MB0387.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/22/18 3:25 PM, Elliott, Robert (Persistent Memory) wrote:
> 
> 
>> On 1/20/18 7:23 PM, Goldwyn Rodrigues wrote:
>>> On 01/20/2018 08:11 PM, Andi Kleen wrote:
>>>> Goldwyn Rodrigues <rgoldwyn@suse.de> writes:
>>>>> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
>>>>> In case direct I/O encounters an error midway, it returns the error.
>>>>> Instead it should be returning the number of bytes transferred so far.
>>>>
>>>> It's likely there's a lot of code in user space that does
>>>>
>>>>      if (write(..., N) < 0) handle error
>>>>
>>>> With your change it would need to be
>>>>
>>>>      if (write(..., N) != N) handle error
>>>>
>>>> How much code is actually doing that?
>>>>
>>>> I can understand it fixes your artifical test suite, but it seems to me your
>>>> change has a high potential to break a lot of existing user code
>>>> in subtle ways. So it seems to be a bad idea.
>>>>
>>>> -Andi
>>>
>>> Quoting 'man 2 write':
>>>
>>> RETURN VALUE
>>>  On  success,  the  number  of bytes written is returned (zero indicates
>>>  nothing was written).  It is not an error if  this  number  is smaller
>>>  than the number of bytes requested; this may happen for example because
>>>  the disk device was filled.  See also NOTES.
>>
>> You can quote as much man page as you want - Andi is well aware of how
>> read/write system call works, as I'm sure all of us are, that is not the
>> issue. The issue is that there are potentially LOTS of applications out
>> there that do not check for short writes, they do exactly what Andi
>> speculated above. If you break it with this change, it doesn't matter
>> what's in the man page. What matters is previous behavior, and that
>> you are breaking user space. At that point nobody cares what's in the
>> man page.
>  
> 
> fio engines/sg.c fio_sgio_rw_doio() has that pattern:
> 
> 	ret = write(f->fd, hdr, sizeof(*hdr));
> 	if (ret < 0)
> 		return ret;
> 	...
> 	return FIO_Q_QUEUED;   [which is 1]
> 
> although there might be special circumstances for the sg interface
> making that safe.

That's for SG scsi direct IO, I don't think that supports partial
IO since it's sending raw SCSI commands.

For the regular libaio or sync IO system calls, fio of course checks
and handles short IOs correctly. It even logs if it got any.

-- 
Jens Axboe
