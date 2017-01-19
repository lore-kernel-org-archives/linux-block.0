Return-Path: <linux-fsdevel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cd3be689-9f7c-d5ad-1482-1d45944bed66@suse.de>
References: <CACVXFVO2hPfu1G_ASzHLVvFgDdVR8HTNitGPVYRbq-ovMNabAw@mail.gmail.com>
 <cd3be689-9f7c-d5ad-1482-1d45944bed66@suse.de>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 19 Jan 2017 16:27:36 +0800
Message-ID: <CACVXFVP0yO6dabybZR6FGDJMdVUL=eQ8_2C5hy+7L6FDMyZ7bw@mail.gmail.com>
Subject: Re: [LSF/MM ATTEND] block: multipage bvec upstreaming & next step
To: Coly Li <colyli@suse.de>
Cc: lsf-pc@lists.linux-foundation.org,
        linux-block <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Hi Coly,

On Thu, Jan 19, 2017 at 3:57 PM, Coly Li <colyli@suse.de> wrote:
> On 2017/1/17 =E4=B8=8A=E5=8D=8811:56, Ming Lei wrote:
>> Hi Guys,
>>
>> The multipage bvec patchset[1] has been posted out for a while, and
>> xfstest(ext4, xfs and btrfs) have been run and no regression is
>> observed, and I hope having talk about this in person would help
>> moving it forward.
>>
>> Secondly I'd like to discuss with guys about the following next steps
>> of mp-bvec:
>>
>> 1) cleanup raid1/raid5/raid10 for removing the only singlepage bvec path
>
> Hi Ming,
>
> I am interested on this topic. Could you please provide a hint that what
> is the proper way to remove single page bvec from md raid code ?

Basically speaking the raid code can't access the bvec table directly like
referencing .bi_vcnt or .bi_io_vec once multipage bvec is supported,
especially after pages are added to the bio via bio_add_page().

I am looking at the raid1 code, and maybe we can discuss a bit
about the cleanup.

> And
> will dm code involved in as well ?

No, nothing at all, and no such usage in dm code.


Thanks,
Ming Lei
