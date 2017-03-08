Return-Path: <axboe@kernel.dk>
Subject: Re: BIO request larger than our storage device supports in linux
 kernel 4.x
To: Umesh Patel <Umesh.Patel@wdc.com>, Christoph Hellwig <hch@infradead.org>
References: <CY1PR0401MB13538108F3DFD6738AFC8A34E12E0@CY1PR0401MB1353.namprd04.prod.outlook.com>
 <CY1PR0401MB1353279ED2A07E69F8ED42B5E12E0@CY1PR0401MB1353.namprd04.prod.outlook.com>
 <04c47362-2e9d-b32a-fb98-14113b45b6f7@kernel.dk>
 <CY1PR0401MB1353F97FF898FB07AB7E5AD3E12E0@CY1PR0401MB1353.namprd04.prod.outlook.com>
 <211c3042-5f72-def6-4ede-510fa99ef683@kernel.dk>
 <CY1PR0401MB1353D1D8B5FB4E58AE1ABA5EE12E0@CY1PR0401MB1353.namprd04.prod.outlook.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cbd74faf-455d-eacb-9d1b-e10687d6541d@kernel.dk>
Date: Wed, 8 Mar 2017 11:22:50 -0700
MIME-Version: 1.0
In-Reply-To: <CY1PR0401MB1353D1D8B5FB4E58AE1ABA5EE12E0@CY1PR0401MB1353.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/08/2017 11:20 AM, Umesh Patel wrote:
>> You are doing it wrong, you should be writing this as a blk-mq driver.
>> Not only would that fix your issue, it would also solve a host of
>> other issues that I'm sure your driver has since it hasn't even been
>> reviewed.
> 
> [Umesh] : This has been working since 2.x kernel to till 3.18. It has
> this issue only in 4.x.

And had your driver been in the kernel, it would still be working. I already
told you what is wrong, go back and read the first reply.

-- 
Jens Axboe
