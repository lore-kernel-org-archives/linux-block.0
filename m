Return-Path: <shaun.tancheff@seagate.com>
MIME-Version: 1.0
In-Reply-To: <20160801094116.GB14677@lst.de>
References: <1469818955-20568-1-git-send-email-shaun@tancheff.com> <20160801094116.GB14677@lst.de>
From: Shaun Tancheff <shaun.tancheff@seagate.com>
Date: Mon, 1 Aug 2016 12:07:41 -0500
Message-ID: <CAJVOszCAb4o5LWpJL8Yd66n9jPvy+EMQX2Xfr6awZCxfGJf_CA@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Block layer support ZAC/ZBC commands
To: Christoph Hellwig <hch@lst.de>
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Josh Bingaman <josh.bingaman@seagate.com>,
        Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@hgst.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 1, 2016 at 4:41 AM, Christoph Hellwig <hch@lst.de> wrote:
>
> Can you please integrate this with Hannes series so that it uses
> his cache of the zone information?

Adding Hannes and Damien to Cc.

Christoph,

I can make a patch the marshal Hannes' RB-Tree into to a block report, that=
 is
quite simple. I can even have the open/close/reset zone commands update the
RB-Tree .. the non-private parts anyway. I would prefer to do this around t=
he
CONFIG_SD_ZBC support, offering the existing type of patch for setups that =
do
not need the RB-Tree to function with zoned media.

I do still have concerns with the approach which I have shared in smaller
forums but perhaps I have to bring them to this group.

First is the memory consumption. This isn't really much of a concern for la=
rge
servers with few drives but I think the embedded NAS market will grumble as
well as the large data pods trying to stuff 300+ drives in a chassis.

As of now the RB-Tree needs to hold ~30000 zones.
sizeof() reports struct blk_zone to use 120 bytes on x86_64. This yields
around 3.5 MB per zoned drive attached.
Which is fine if it is really needed, but most of it is fixed information
and it can be significantly condensed (I have proposed 8 bytes per zone hel=
d
in an array as more than adequate). Worse is that the crucial piece of
information, the current wp needed for scheduling the next write, is mostly
out of date because it is updated only after the write completes and zones
being actively written to must work off of the last location / size that wa=
s
submitted, not completed. The work around is for that tracking to be handle=
d
in the private_data member. I am not saying that updating the wp on
completing a write isn=E2=80=99t important, I am saying that the bi_end_io =
hook is
the existing hook that works just fine.

This all tails into domain responsability. With the RB-Tree doing half of t=
he
work and the =E2=80=98responsible=E2=80=99 domain handling the active path =
via private_data
why have the split at all? It seems to be a double work to have second obje=
ct
tracking the first so that I/O scheduling can function.

Finally is the error handling path when the RB-Tree encounters and error it
attempts to requery the drive topology virtually guaranteeing that the
private_data is now out-of-sync with the RB-Tree. Again this is something
that can be better encapsulated in the bi_end_io to be informed of the
failed I/O and schedule the appropriate recovery (including re-querying the
zone information of the affected zone(s)).

Anyway those are my concerns and why I am still reluctant to drop this line=
 of
support. I have incorporated Hannes changes at various points. Hence the
SCT Write Same to attempt to work around some of the flaws in mapping
discard to reset write pointer.

Thanks and Regards,
Shaun

> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp=
-3A__vger.kernel.org_majordomo-2Dinfo.html&d=3DCwIBAg&c=3DIGDlg0lD0b-nebmJJ=
0Kp8A&r=3DWg5NqlNlVTT7Ugl8V50qIHLe856QW0qfG3WVYGOrWzA&m=3D0ZPyN4vfYZXSmuCmI=
m3wpExF1K28PYO9KmgcqDsfQBg&s=3Daiguzw5_op7woZCZ5Qi7c36b16SxiWTJXshN0dG3Xyo&=
e=3D



--=20
Shaun Tancheff
