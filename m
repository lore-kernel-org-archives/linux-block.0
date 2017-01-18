Return-Path: <linux-fsdevel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170118210241.GE10498@birch.djwong.org>
References: <at1mp6pou4lenesjdgh22k4p.1484345585589@email.android.com>
 <b9rbflutjt10mb4ofherta8j.1484345610771@email.android.com>
 <SN2PR04MB2191756EABCB0E9DAA3B5328887B0@SN2PR04MB2191.namprd04.prod.outlook.com>
 <20170114004910.GA4880@omniknight.lm.intel.com> <SN2PR04MB2191A6EDB7203AF86600FD25887D0@SN2PR04MB2191.namprd04.prod.outlook.com>
 <20170117143703.GP2517@quack2.suse.cz> <20170117221421.GC4880@omniknight.lm.intel.com>
 <20170118101641.GD24789@quack2.suse.cz> <x49r3406r2i.fsf@segfault.boston.devel.redhat.com>
 <20170118210241.GE10498@birch.djwong.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 18 Jan 2017 13:32:04 -0800
Message-ID: <CAPcyv4hd7bpCa7d9msX0Y8gLz7WsqXT3VExQwwLuAcsmMxVTPg@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] Badblocks checking/representation in filesystems
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Jeff Moyer <jmoyer@redhat.com>, Jan Kara <jack@suse.cz>,
        Slava Dubeyko <Vyacheslav.Dubeyko@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Wed, Jan 18, 2017 at 1:02 PM, Darrick J. Wong
<darrick.wong@oracle.com> wrote:
> On Wed, Jan 18, 2017 at 03:39:17PM -0500, Jeff Moyer wrote:
>> Jan Kara <jack@suse.cz> writes:
>>
>> > On Tue 17-01-17 15:14:21, Vishal Verma wrote:
>> >> Your note on the online repair does raise another tangentially related
>> >> topic. Currently, if there are badblocks, writes via the bio submission
>> >> path will clear the error (if the hardware is able to remap the bad
>> >> locations). However, if the filesystem is mounted eith DAX, even
>> >> non-mmap operations - read() and write() will go through the dax paths
>> >> (dax_do_io()). We haven't found a good/agreeable way to perform
>> >> error-clearing in this case. So currently, if a dax mounted filesystem
>> >> has badblocks, the only way to clear those badblocks is to mount it
>> >> without DAX, and overwrite/zero the bad locations. This is a pretty
>> >> terrible user experience, and I'm hoping this can be solved in a better
>> >> way.
>> >
>> > Please remind me, what is the problem with DAX code doing necessary work to
>> > clear the error when it gets EIO from memcpy on write?
>>
>> You won't get an MCE for a store;  only loads generate them.
>>
>> Won't fallocate FL_ZERO_RANGE clear bad blocks when mounted with -o dax?
>
> Not necessarily; XFS usually implements this by punching out the range
> and then reallocating it as unwritten blocks.
>

That does clear the error because the unwritten blocks are zeroed and
errors cleared when they become allocated again.
