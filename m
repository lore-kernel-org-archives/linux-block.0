Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam02on0042.outbound.protection.outlook.com ([104.47.36.42]:52132
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751434AbdBYTSG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Feb 2017 14:18:06 -0500
Subject: Re: [PATCH 1/2] lightnvm: add generic ocssd detection
To: Christoph Hellwig <hch@infradead.org>
References: <20170224171649.27409-1-matias@cnexlabs.com>
 <20170225182117.GA26447@infradead.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias@cnexlabs.com>
Message-ID: <8cce0bfd-a153-ba4e-0d84-bea29764982e@cnexlabs.com>
Date: Sat, 25 Feb 2017 20:16:04 +0100
MIME-Version: 1.0
In-Reply-To: <20170225182117.GA26447@infradead.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/25/2017 07:21 PM, Christoph Hellwig wrote:
> On Fri, Feb 24, 2017 at 06:16:48PM +0100, Matias Bj�rling wrote:
>> More implementations of OCSSDs are becoming available. Adding each using
>> pci ids are becoming a hassle. Instead, use a 16 byte string in the
>> vendor-specific area of the identification command to identify an
>> Open-Channel SSD.
>>
>> The large string should make the collision probability with other
>> vendor-specific strings to be near nil.
>
> No way in hell.  vs is vendor specific and we absolutely can't overload
> it with any sort of meaning.  Get OCSSD support properly standardized and
> add a class code for it.  Until then it's individual PCI IDs.
>

You are right, that is the right way to go, and we are working on it. In 
the meantime, there are a couple of reasons I want to do a pragmatic 
solution:

1. Enabling open-channel SSDs on NVMeoF. Customers are asking to use 
OCSSDs with NVMoeF. I do not think detection of PCI ids works with that.

2. Some vendors are circumventing the OCSSD detection by utilizing the 
CNEX Labs PCI ids. That is not very helpful and shows that there is a 
need for a generic approach. When they become public and will use their 
PCI id (if they will do that...), it is cumbersome to backport their PCI 
ids back to previous kernel versions to detect support.

3. Things are not a technical issue for why this is not adopted today. 
It will be soon enough one way or another, but until then, a pragmatic 
approach would go a long way.

If identify VS is too specific, is there another combination that solves 
the above in a generic and practical way that would satisfy you and the 
above?

-Matias
