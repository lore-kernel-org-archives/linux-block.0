Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme updates for Linux 4.15
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20171110143407.zapukx3fhfcr4fm5@infradead.org>
 <e4ae08a2-4724-6ae5-6e64-7f42fb825bad@kernel.dk>
Message-ID: <fe9a0a40-11d0-97b4-86e1-ba66d3932eb1@kernel.dk>
Date: Fri, 10 Nov 2017 08:22:32 -0700
MIME-Version: 1.0
In-Reply-To: <e4ae08a2-4724-6ae5-6e64-7f42fb825bad@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/10/2017 08:18 AM, Jens Axboe wrote:
> On 11/10/2017 07:34 AM, Christoph Hellwig wrote:
>> Hi Jens,
>>
>> another round of NVMe updates for 4.15.
>>
>> The biggest items are:
>>
>>  - native multipath support (me + Hannes)
>>  - userspace notifications for AENs (Keith)
>>  - obey the command effects log page (Keith)
>>
>> in addition to that lots of fixes from a wide variety of people.
> 
> Pulled. It had two conflicts with master, but both pretty trivial.

Actually, double checking, one of them is a little suspicious:

        if (a == &dev_attr_uuid.attr) {
<<<<<<< HEAD
                if (uuid_is_null(&ns->uuid) &&
                    !memchr_inv(ns->nguid, 0, sizeof(ns->nguid)))
=======
                if (uuid_is_null(&ids->uuid) ||
                    !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
>>>>>>> 34a9690712aa386fb5fa9e3b8fb44a22f5f2aec6
                        return 0;
        }

with the previous copy using is_null && memchr_inv, the change to ids
makes it an OR instead. I'm going with the latter, but thought I'd bring
it up.

-- 
Jens Axboe
