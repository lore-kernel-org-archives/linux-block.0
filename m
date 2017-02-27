Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Subject: Re: [PATCH 1/2] lightnvm: add generic ocssd detection
To: Christoph Hellwig <hch@infradead.org>,
 =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias@cnexlabs.com>
References: <20170224171649.27409-1-matias@cnexlabs.com>
 <20170225182117.GA26447@infradead.org>
 <8cce0bfd-a153-ba4e-0d84-bea29764982e@cnexlabs.com>
 <20170226064701.GA7557@infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <108882ac-9f55-e4f5-c04e-244848139db8@grimberg.me>
Date: Mon, 27 Feb 2017 20:35:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170226064701.GA7557@infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>


> [adding linux-nvme to Cc as the patch changes the nvme driver, despite
> the subject line]
>
> On Sat, Feb 25, 2017 at 08:16:04PM +0100, Matias Bj=F8rling wrote:
>> On 02/25/2017 07:21 PM, Christoph Hellwig wrote:
>>> On Fri, Feb 24, 2017 at 06:16:48PM +0100, Matias Bj=F8rling wrote:
>>>> More implementations of OCSSDs are becoming available. Adding each usi=
ng
>>>> pci ids are becoming a hassle. Instead, use a 16 byte string in the
>>>> vendor-specific area of the identification command to identify an
>>>> Open-Channel SSD.
>>>>
>>>> The large string should make the collision probability with other
>>>> vendor-specific strings to be near nil.
>>>
>>> No way in hell.  vs is vendor specific and we absolutely can't overload
>>> it with any sort of meaning.  Get OCSSD support properly standardized a=
nd
>>> add a class code for it.  Until then it's individual PCI IDs.
>>>
>>
>> You are right, that is the right way to go, and we are working on it. In=
 the
>> meantime, there are a couple of reasons I want to do a pragmatic solutio=
n:
>
> Reasonable reaosons, but that's just not how standard interfaces work.
> Either you standardize the behaviour and have a standardized trigger
> for it, or it is vendor specific and needs to be keyed off a specific
> vendor/device identification.

I agree, I don't see how we're allowed to use vs for that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
