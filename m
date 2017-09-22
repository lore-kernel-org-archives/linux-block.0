Return-Path: <horvatmate@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170914081757.c64qa6pp2zi5hmda@linux-x5ow.site>
References: <1505317073-22567-1-git-send-email-philipp.guendisch@fau.de> <20170914081757.c64qa6pp2zi5hmda@linux-x5ow.site>
From: =?UTF-8?B?TcOhdMOpIEhvcnbDoXRo?= <horvatmate@gmail.com>
Date: Fri, 22 Sep 2017 11:54:36 +0200
Message-ID: <CA+3umMVAc1LiuHsY=Sj6p-5d6ubyZJW1gMoYi0d5gYOQEgrCfg@mail.gmail.com>
Subject: Re: [PATCH] Support for secure erase functionality
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Philipp Guendisch <philipp.guendisch@fau.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	damien.lemoal@wdc.com, axboe@kernel.dk, viro@zeniv.linux.org.uk,
	bart.vanassche@sandisk.com, martin.petersen@oracle.com, hare@suse.de,
	osandov@fb.com, dan.j.williams@intel.com, ming.lei@redhat.com,
	linux-kernel@i4.cs.fau.de
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Dear Johannes Thumshirn,

> How can this work with CoW filesystems?

Because we are a layer below filesystems, that depends on the actual
implementation.
If the discards are issued to the right sectors on the drive, we write
into those sectors.


>> Built against torvalds/linux
>
> This should go below the '---' so git am doesn't write it into the change=
log.

Thanks for the hint, we messed that up.


> Which filesystems commonly used in production are left afterwards?

The list of filesystems you see in the code are the working ones
(except btrfs, that apparently
doesn't mount a block device, so it doesn't run into our code - we
have to look into that).
Which other filesystems do you miss?

> I'm sorry, but while I get that this sounds like a nice feature for a pap=
er or
> reasearch project, I don't see why it should be used on production system=
s at
> all.

This feature could be used, if you can't afford to use a full disk
encryption, but still want to
erase sensitive data on the fly. As you probably read in the other
mails, this solution is
not forensic-proof, but with a normal data recovery tool, you
shouldn't be able to recover
more than the file name

Best regards,
M=C3=A1t=C3=A9 Horv=C3=A1th


2017-09-14 10:17 GMT+02:00 Johannes Thumshirn <jthumshirn@suse.de>:
> On Wed, Sep 13, 2017 at 05:37:53PM +0200, Philipp Guendisch wrote:
>> This patch adds a software based secure erase option to improve data
>> confidentiality. The CONFIG_BLK_DEV_SECURE_ERASE option enables a mount
>> flag called 'sw_secure_erase'. When you mount a volume with this flag,
>> every discard call is prepended by an explicit write command to overwrit=
e
>> the data before it is discarded. A volume without a discard compatibilit=
y
>> can be used as well but the discard calls will be enabled for this devic=
e
>> and suppressed after the write call is made.
>
> How can this work with CoW filesystems?
>
>>
>> Built against torvalds/linux
>
> This should go below the '---' so git am doesn't write it into the change=
log.
>
>
> [...]
>
>> +     if (strcmp(fs_type->name, "ext4") !=3D 0 &&
>> +         strcmp(fs_type->name, "btrfs") !=3D 0 &&
>> +         strcmp(fs_type->name, "gfs2") !=3D 0 &&
>> +         strcmp(fs_type->name, "gfs2meta") !=3D 0 &&
>> +         strcmp(fs_type->name, "xfs") !=3D 0 &&
>> +         strcmp(fs_type->name, "jfs") !=3D 0) {
>> +             pr_warn("fs: The mounted %s filesystem on drive %s does no=
t generate discards, secure erase won't work",
>> +                             fs_type->name, dev_name);
>> +     }
>> +skip:
>> +#endif
>
> Which filesystems commonly used in production are left afterwards?
>
> I'm sorry, but while I get that this sounds like a nice feature for a pap=
er or
> reasearch project, I don't see why it should be used on production system=
s at
> all.
>
> Byte,
>         Johannes
> --
> Johannes Thumshirn                                          Storage
> jthumshirn@suse.de                                +49 911 74053 689
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N=C3=BCrnberg)
> Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
