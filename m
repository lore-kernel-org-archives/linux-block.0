Return-Path: <linux-fsdevel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161213181511.GB2305@redhat.com>
References: <20161213181511.GB2305@redhat.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 14 Dec 2016 14:55:28 +1100
Message-ID: <CAKTCnzkniWn_ayN9LsXzc9GRBQAaq_gqmvWu0-aELUxkCzkXMA@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] Un-addressable device memory and block/fs implications
To: Jerome Glisse <jglisse@redhat.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm <linux-mm@kvack.org>,
        linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Wed, Dec 14, 2016 at 5:15 AM, Jerome Glisse <jglisse@redhat.com> wrote:
> I would like to discuss un-addressable device memory in the context of
> filesystem and block device. Specificaly how to handle write-back, read,
> ... when a filesystem page is migrated to device memory that CPU can not
> access.
>
> I intend to post a patchset leveraging the same idea as the existing
> block bounce helper (block/bounce.c) to handle this. I believe this is
> worth discussing during summit see how people feels about such plan and
> if they have better ideas.
>
>
Yes, that would be interesting. I presume all of this is for
ZONE_DEVICE and HMM.
I think designing such an interface requires careful thought on tracking pages
to ensure we don't lose writes and also the impact on things like the
writeback subsytem.

>From a HMM perspective and an overall MM perspective, I worry that our
accounting
system is broken with the proposed mirroring and unaddressable memory that
needs to be addressed as well.

It would also be nice to have a discussion on migration patches currently on the
list

1. THP migration
2. HMM migration
3. Async migration

> I also like to join discussions on:
>   - Peer-to-Peer DMAs between PCIe devices
>   - CDM coherent device memory

Yes, this needs discussion. Specifically from is all of CDM memory NORMAL or not
and the special requirements we have today for CDM.

>   - PMEM
>   - overall mm discussions

Balbir Singh.
