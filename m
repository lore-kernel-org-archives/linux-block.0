Return-Path: <jonathan.derrick@intel.com>
Subject: Re: [PATCHv3 4/4] MAINTAINERS: Remove powerpc's opal match
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jens Axboe <axboe@kernel.dk>,
 Rafael Antognolli <rafael.antognolli@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 Scott Bauer <scott.bauer@intel.com>
References: <1487187731-10293-1-git-send-email-jonathan.derrick@intel.com>
 <1487187731-10293-5-git-send-email-jonathan.derrick@intel.com>
 <87poiik8tb.fsf@concordia.ellerman.id.au>
From: Jon Derrick <jonathan.derrick@intel.com>
Message-ID: <64674df8-8e5e-07a0-8062-d02e588b2a32@intel.com>
Date: Thu, 16 Feb 2017 09:14:36 -0700
MIME-Version: 1.0
In-Reply-To: <87poiik8tb.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

Thanks everyone. Sorry about the mess :)

On 02/15/2017 10:23 PM, Michael Ellerman wrote:
> Jon Derrick <jonathan.derrick@intel.com> writes:
> 
>> PPC's 'opal' match pattern also matches block/sed-opal.c, where it looks
>> like the 'arch/powerpc' file pattern should be enough to match powerpc
>> opal code by itself. Remove the opal regex pattern from powerpc.
> 
> We thought of it first.
> 
> Can't you just rename your driver, Opal Storage Specification, so "oss",
> that should be pretty unique?
> 
> ... :)
> 
> I don't like this version, but I'll merge the one from Stewart which
> drops the pattern and adds the paths for the existing drivers.
> 
> cheers
> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b983b25..430dd02 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7404,7 +7404,6 @@ F:	drivers/pci/hotplug/pnv_php.c
>>  F:	drivers/pci/hotplug/rpa*
>>  F:	drivers/scsi/ibmvscsi/
>>  F:	tools/testing/selftests/powerpc
>> -N:	opal
>>  N:	/pmac
>>  N:	powermac
>>  N:	powernv
>> -- 
>> 1.8.3.1
