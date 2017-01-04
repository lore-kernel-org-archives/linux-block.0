Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Wed, 4 Jan 2017 15:07:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Leech <cleech@redhat.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Duncan <lduncan@suse.com>, open-iscsi@googlegroups.com,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [4.10, panic, regression] iscsi: null pointer deref at
        iscsi_tcp_segment_done+0x20d/0x2e0
Message-ID: <20170104140717.GA24608@lst.de>
References: <20161222051322.GF4758@dastard> <CA+55aFza=cv6TGYh+Be1xz2x-G-U=vruhbmfGpHSqY1ocZrBeg@mail.gmail.com> <20161222065012.GI4758@dastard> <20161222185030.so4btkuzzkih3owz@straylight.hirudinean.org> <CACVXFVOGoh+AEGSSMsbxfdAjZQS5k_t+7uR-+qwusm0vfauHEA@mail.gmail.com> <20161223000356.dxwkgsei32w7hc4f@straylight.hirudinean.org> <20161223100014.GA29467@lst.de> <CA+55aFxA1LE+4jdR8YXZyRVJ-MpOCUVob=ESBsMPuW=Qb=px-A@mail.gmail.com> <20161224100756.GA16741@lst.de> <a9fc4c0b-8521-84cc-66f6-48396c095539@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a9fc4c0b-8521-84cc-66f6-48396c095539@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Sat, Dec 24, 2016 at 02:17:26PM +0100, Hannes Reinecke wrote:
> Christoph, do you have a pointer to your patchset?

Here is a pointer to the current one after splitting it into properly
bisectable chunks.  Besides proper changelogs the biggest item left
is fixing up dm-mpath to not allocate its own request structures.

http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/block-pc-refactor
