Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794348500;
	b=xlmclLbQik9V3pEy/dgkEZbp4Cq1s+tr184Rxreg2y5djf+wcXeEV5m3wKO/B+M9rzEC
	 16HKoCQ4g1+sKlAJHpdvJl2oVE0v/+q9A4Wpzo9zl9jauPT8yBg28nsvFYnP8n3XYKLJT
	 zlSN5EjRLB3PuViZjLUW3KTwxAc81q50eRG0AKqteI8k7+2xKa78UmzfVvcNtio9ljHhb
	 Pv3WKXQEfcrm9rqwxsETQwfy1PcpfqLQTfV7tO0ekEHOq24Cu1+HfpvYLckKQhoEDPBpf
	 gh3UDq5JjDz3z5bX565hgmmwzeMKA0gy5Im/tg59vMk4BJrVxCM+k0ZMCDNK8aK4K5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9d5lzQZBiofcX+00oxDbZE4ZZEA0GJviWevYoM/JUhg=;
	b=XvViilvCwOIkJUhaSUGNfd7uv4qQiR03UxBtdaOeST4D7LUieJ+tHsmSdT4AhtFttWSY
	 9eMEy7r9O97LZppKYS/w+abDHmx5VRwa1/qk46azYgKI3/FhPU/Z2+Loei2fD1zZv0bH+
	 C2s6PyKm1q663fPVqgiXczDksocwrnT6dQjNCUP4L7NvjbHv7mN+xxpTNbUCFsxR0SuYg
	 T2f2XeOVxbVXp7pvS6JVSXA8Ogke+jvrglpjQ1LoNjMeCeaLAV+vQJVmaBd1HRIEclyeF
	 3DwYJFWbKbQOH7jkVtfzMLZqZVoclzU5DDGZ2OBdj+uyzJdK3pwFr/ViwPRqmOcW01w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=artiphishell.com;
	spf=pass smtp.mailfrom=artiphishell.com;
	dkim=pass header.d=artiphishell.com header.i=@artiphishell.com header.a=rsa-sha256 header.s=google header.b=XfWkIAKy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E3360A3826
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 22:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9E3360A3826
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=artiphishell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artiphishell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=artiphishell.com header.i=@artiphishell.com header.a=rsa-sha256 header.s=google header.b=XfWkIAKy
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-490d59c3edaso1862703f8f.1
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 14:08:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794348498; cv=none;
        d=google.com; s=arc-20260327;
        b=bzFdUSKzK6mZIOu6f2RHiKA2wu1gShVXBOK4rVSINJRjjI7+QofGM3OKNiLI9XQ8Eg
         x71H5dq6/uMG5H0/r6mdLGL+6BxixO9V9wLUO48a1oQ705lcrBvap9EdgK0r2M1J7AOQ
         VH+ayjT12hYg/DpmdQ1j5vyecFj7D1TyYut/ZufeZqcJoZSdijv2543zjCpDf5m6WD5I
         JrOb0Zpg4x/J1c3PZxsYCPS2DWsAz5yh0ab1b/Usb2xj9kfv4mZrA4R5/04VKhT7W5Wn
         FQNTFPgCXeg1M1xaS0CdV4bsBMNfvv/4kSVihwbHpCqW0T2SOsKAEYmij/1GhIzkhjpV
         0Qrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9d5lzQZBiofcX+00oxDbZE4ZZEA0GJviWevYoM/JUhg=;
        fh=JRJ4jV6GuFGBjr6xg8rXQkiHkxcVNhUNwi1EXDijD3Y=;
        b=M2p+7FV6chCLGaSCrWkrJMuHrEsgZ/FZfa0BTHlQM3IGSVt35SmZV/YsWSHUJDyXEf
         OtXqmJgfnrpdJ5tWlszxp4pqvOpzHwlRRbmmgOX9RtHYPTlUrl6lH6H9lRgvIF9yONXP
         aMzkFp4oR1GbBGUcrCZ+xB4H05yJkchdqOi5v7DUEEXR8R7VPwJacoQQRW4oFoGPSCy9
         Xmtm8Hz04SdvINuAvdJmLDElcvBys2no0Op50kPN/xVyCd8ITOpbsfFM/31Q/C+P9pwm
         4G+R5f5dnf9lovFYkflK1i58jq3ns/Cj3BHoH7zl7Bd4RYAeuIf3Ki2LgzE1BaFxaxjJ
         YaWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=artiphishell.com; s=google; t=1794348498; x=1794953298; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9d5lzQZBiofcX+00oxDbZE4ZZEA0GJviWevYoM/JUhg=;
        b=XfWkIAKytkU5Dd98AQuZaA8z0aPiclBMKUNef4lhu9n1FzVLzXm5/2qf+2edTzSkg0
         OkW8itB3m56HAvf7zUp3XP/219YTa+LpNfD7GpgfnJimnrNe2LqhCfrJQ+GUJRUBp6zx
         XSa2Ch7ZmPILsF01QqW80oGhnLpAnbwe4/FITcSSe8Fx4WnT0Rx0JcGNJ/O1XBGdClta
         xWmjHSUzPAvST8HmZce4GIlfIWqWpRl+MyBMrBApBBmcNZgV1+o95RX0cVg6UdV2NZ6+
         qYHFUdq4q00+Crr5SfS3VmGXLN1LTv2YgxcpUP4d85sFd9v7swtSPQjNwuRs75tO702S
         JfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794348498; x=1794953298;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9d5lzQZBiofcX+00oxDbZE4ZZEA0GJviWevYoM/JUhg=;
        b=bB1pzfAS3TxrTwPGidklaCS5hVLcgx0kKekhJAZzbi5NJc4L6iLfsI/PLkroXaTV/d
         QXeoxn/iE4Ru0cV0Y2/UGQ4Jc+KjKwPCV/KvYEZADnYCgHk1B4SPBI0I5Aq5pYqQfau7
         yHQFQU9hExHx7hxunvTcuWB5E7FeTQ4Ok6yW7UY4mbSI/oPNI3WgxzxVULSAGUqLAcGA
         hOho3OgLlqlzV3udppeMQ/rhuk0wKQXIu07ZgizuIsSaExzr3N3oVLQRGBWtpZHq9eqv
         S3Lv08CHua+y54YdOOWNAJ2QByP12gtYnnUrDuzDcV5NLSn7pLpS8BNd7NMCDvPmob1a
         uC8A==
X-Forwarded-Encrypted: i=1; AL+hErHoSdulI5n0CCfumCje1EXll17IF2mItd5K+qfc8LpObiuszoXZEmM8f3HDB08NMtvA8zcJmQvU9bCzAw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/SbMUWoKzt1fpnF9R5EhrcnWXwPFLvaGP0wmaSbPrZMZ8YSU36
	f8fTlYWod0lMkAU725GKMr1gxQNUUsf1U0OEHVncxqvKz45ePv+4XGWtgCVDLAw4DFaDxsyD2qY
	gkuaB5jWsGtiw0HMQwXiEZJOnsMV904CK0GEVClq40826prudxP1QnDVddRdTze/H
X-Gm-Gg: AYBFou3k/oLnXUxRL1ID+GGh1y2LwKB5Po4DIEQH2Ms6t1HAyNkbrY010LhZgQqCgi5
	Djti0FHHY2eypimDMdIjvu4vFBnEf7UG30I09dHTv6vDag+t/T/wVjAowTZZ9QNJJkC8TlSpgto
	i1WsY+L0iTL07/5LKxn34OIJpsFjb9bk/OkKwV8LXbQVkvUMRGiuye7/kNylVyum+KUFUmzER0X
	ClFTZUk+qsX1tvspdRfEqc8vP1BN87g3+iTynR+UY0581dQo4on4PqTQlFBqLGVx3PYDY8+dqaH
	ZXdk3B+aV2EB6H1yz9OWe1zmpFfNB25WQsYtcLoNV5SWewzRUbVfGORnlAzFgGzsTFt3oSp9dxl
	FNBqaqqk0+kmpZk/nn2GbY0YwZ2R5lLueINbWnDGSUR3J1emFieFs9ynAbg8MNG5Bdg==
X-Received: by 2002:a05:6000:26c6:b0:48e:7475:fe7b with SMTP id
 ffacd0b85a97d-49995ea11f6mr1535918f8f.6.1794348498026; Tue, 10 Nov 2026
 14:08:18 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022181955.35758-1-jay@artiphishell.com> <avOQ66kCxOghtFp4@equinox>
In-Reply-To: <avOQ66kCxOghtFp4@equinox>
From: Jay Vadayath <jay@artiphishell.com>
Date: Tue, 10 Nov 2026 15:08:05 -0700
X-Gm-Features: AclHuK_x_gSedLpiXqF-mReJPLrnM-YH0mKfOC_UB9zkN4PzXJlBPe1svsENvyU
Message-ID: <CACd3oYMZ+umLbeK3q8oaJUwZHC4zbbFOe1YVEAq3s2v4B+d5Dw@mail.gmail.com>
Subject: Re: [PATCH] cdrom: bound the device-supplied offset in cdrom_mrw_set_lba_space
To: Phillip Potter <phil@philpotter.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

Thank you for your response and for taking a look at this.
I am happy to make the changes you requested.
However, I wanted to clarify if you would like me to start a new email
thread with the updated format ?

Or was the idea to just follow up on this thread and repost the same
email with the updated format ?

Please let me know how you would like to proceed.

Thank you.


On Tue, Nov 10, 2026 at 2:47=E2=80=AFPM Phillip Potter <phil@philpotter.co.=
uk> wrote:
>
> On Thu, Oct 22, 2026 at 11:19:55AM -0700, Jay Vadayath wrote:
> > cdrom_mrw_set_lba_space() issues a MODE SENSE(10) into a 16-byte stack
> > buffer (char buffer[16]), then takes offset =3D be16_to_cpu(mph->desc_l=
ength)
> > straight from reply bytes 6..7 and does buffer[offset + 3] =3D space. T=
he
> > desc_length field is fully device-controlled (0..65535) and nothing
> > checks that offset + 3 lies within the buffer, nor that size (derived
> > from mode_data_length) fits. A drive that returns desc_length =3D 24 tu=
rns
> > the assignment into buffer[27] =3D space, a one-byte write 12 bytes pas=
t
> > the end of the stack buffer.
> >
> > This runs when an MRW-writable CD-ROM is opened O_RDWR, so a malicious =
or
> > buggy USB/ATAPI drive (or an emulated one) is enough: no privilege beyo=
nd
> > being able to open /dev/sr0 for writing on an attacker-supplied device.
> > The sink lives in the CD-ROM core, so it affects every cdrom driver
> > (sr, ide-cd, pcd, gdrom).
> >
> >   BUG: KASAN: stack-out-of-bounds in cdrom_mrw_set_lba_space.constprop.=
0+0x25c/0x260
> >   Write of size 1 at addr ffff88800639f6db by task poc/133
> >   Call Trace:
> >    dump_stack_lvl+0x64/0x80
> >    print_report+0xd0/0x630
> >    kasan_report+0xe5/0x120
> >    cdrom_mrw_set_lba_space.constprop.0+0x25c/0x260
> >    cdrom_open+0x1169/0x2080
> >    sr_block_open+0x9e/0x140
> >    blkdev_get_whole+0x8c/0x200
> >    bdev_open+0x214/0xc40
> >    blkdev_open+0x1f8/0x370
> >    do_dentry_open+0x408/0x1290
> >    path_openat+0xb2f/0x2210
> >    do_sys_openat2+0x126/0x170
> >    ...
> >
> > Both desc_length (offset) and mode_data_length (size) come straight fro=
m
> > the device reply, so reject anything that would not fit in buffer:
> > offset + 3 >=3D sizeof(buffer) or size > sizeof(buffer) returns -EIO be=
fore
> > the write. The sibling cdrom_mode_select consumer of size is covered by
> > the same guard.
> >
> > This bug was discovered by Artiphishell's vTriage pipeline, which
> > generated an emulated raw-gadget USB BOT CD-ROM (INQUIRY TYPE_ROM
> > advertising MRW-write) plus an open(/dev/sr0, O_RDWR) client that drive=
s
> > the capability-probe chain (page 0x2a -> GET CONFIGURATION CDF_MRW ->
> > MODE SENSE page 0x03 with desc_length =3D 24) and reliably triggers the
> > KASAN report on an unpatched kernel. The fix below was drafted with the
> > Claude coding assistant; a userspace reproducer is available on request=
.
> >
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Jay Vadayath <jay@artiphishell.com>
> > ---
> >  drivers/cdrom/cdrom.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> > index 4f1fd389260f..5e910d79045f 100644
> > --- a/drivers/cdrom/cdrom.c
> > +++ b/drivers/cdrom/cdrom.c
> > @@ -571,6 +571,10 @@ static int cdrom_mrw_set_lba_space(struct cdrom_de=
vice_info *cdi, int space)
> >       offset =3D be16_to_cpu(mph->desc_length);
> >       size =3D be16_to_cpu(mph->mode_data_length) + 2;
> >
> > +     /* Both fields are device-supplied; reject values that overflow b=
uffer[]. */
> > +     if (offset + 3 >=3D (int)sizeof(buffer) || size > (int)sizeof(buf=
fer))
> > +             return -EIO;
> > +
> >       buffer[offset + 3] =3D space;
> >       cgc.buflen =3D size;
> >
> > --
> > 2.51.2
> >
>
> Hi Jay,
>
> Finally got around to looking at this properly, sorry - been very busy
> and life stuff happening too. The fix looks decent as far as I can see.
> Can I ask a few things though please:
>
> (1) Please drop the Assisted-by tag.
> (2) Please remove reference to Claude itself, and mention just "LLM
>     assistance" or such like if you want to (in the description).
> (3) Likewise, please remove or substantially reduce the final paragraph.
>     How the bug was found is (in my view at least) not relevant to the
>     fix, and (perhaps unintentionally) could also read as an
>     advertisement. The relevant information to the mechanism the patch
>     guards against is all contained in your earlier paragraphs anyway.
> (4) Given your inclusion of a call trace anyway, probably worth
>     including a Fixes: tag. This may well just be 1da177e4c3f4 in this
>     case, but it's a good way of signifying this is suitable for
>     backporting.
>
> Hope that's ok? Based on how the patch looks to me, I'm happy to take it
> though provided the above is addressed and no other problems are
> discovered during runtime testing.
>
> Regards,
> Phil



--=20

Regards
Jay Vadayath, Ph.D.  | Co-founder
Artiphishell
