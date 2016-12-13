Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Tue, 13 Dec 2016 13:15:11 -0500
From: Jerome Glisse <jglisse@redhat.com>
To: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [LSF/MM TOPIC] Un-addressable device memory and block/fs implications
Message-ID: <20161213181511.GB2305@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

I would like to discuss un-addressable device memory in the context of
filesystem and block device. Specificaly how to handle write-back, read,
... when a filesystem page is migrated to device memory that CPU can not
access.

I intend to post a patchset leveraging the same idea as the existing
block bounce helper (block/bounce.c) to handle this. I believe this is
worth discussing during summit see how people feels about such plan and
if they have better ideas.


I also like to join discussions on:
  - Peer-to-Peer DMAs between PCIe devices
  - CDM coherent device memory
  - PMEM
  - overall mm discussions

Cheers,
J�r�me
