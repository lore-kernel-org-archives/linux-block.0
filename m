Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Subject: Re: [LSF/MM ATTEND] Un-addressable device memory and block/fs
 implications
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20161213181511.GB2305@redhat.com>
 <87lgvgwoos.fsf@linux.vnet.ibm.com>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Mon, 16 Jan 2017 17:34:51 +0530
MIME-Version: 1.0
In-Reply-To: <87lgvgwoos.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <6304634e-3351-ea81-2970-506b69bc588f@linux.vnet.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On 12/16/2016 08:44 AM, Aneesh Kumar K.V wrote:
> Jerome Glisse <jglisse@redhat.com> writes:
> 
>> I would like to discuss un-addressable device memory in the context of
>> filesystem and block device. Specificaly how to handle write-back, read,
>> ... when a filesystem page is migrated to device memory that CPU can not
>> access.
>>
>> I intend to post a patchset leveraging the same idea as the existing
>> block bounce helper (block/bounce.c) to handle this. I believe this is
>> worth discussing during summit see how people feels about such plan and
>> if they have better ideas.
>>
>>
>> I also like to join discussions on:
>>   - Peer-to-Peer DMAs between PCIe devices
>>   - CDM coherent device memory
>>   - PMEM
>>   - overall mm discussions
> I would like to attend this discussion. I can talk about coherent device
> memory and how having HMM handle that will make it easy to have one
> interface for device driver. For Coherent device case we definitely need
> page cache migration support.

I have been in the discussion on the mailing list about HMM since V13 which
got posted back in October. Touched upon many points including how it changes
ZONE_DEVICE to accommodate un-addressable device memory, migration capability
of currently supported ZONE_DEVICE based persistent memory etc. Looked at the
HMM more closely from the perspective whether it can also accommodate coherent
device memory which has been already discussed by others on this thread. I too
would like to attend to discuss more on this topic.

