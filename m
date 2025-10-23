Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2E230ACEA
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218968; cv=none; b=GzX7fonrSM1ihSWHIvIglwHA93Zz5nfpsGjDQdeGNaGX44MSqpgkSw0M6uQgduMlM1rp7M0cms/fXmlx+CCBxSij2J0H/EbLFBXPEjEYhyAbV8yEykPkOPhJFNbSgUFIs7YZpnHqJ1hgVH960Zg0fzWjIzfqOg9Wq5dCJEjqpiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218968; c=relaxed/simple;
	bh=xp/QLlNgU9yT5Z0c6lOZJJZGC+bWM5/vOMB349Lhr6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Avm0k1ukq3si3V9Hpp2Q0AwhnqMDnwZW8jvYKWfJC9DKjqgtdAx5arIVapBV4qGUO5ZLKSKeI+kOVub4BBQsxaf159FDDDi5tf+tYEvswF9ZuheRqF0jg/Tg3/YueZVyJ2C10xyJ++lWisg9qh5RRa3Y1x29Jj+mqkfXGjcp6L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwfrK8th; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwfrK8th"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b6d5c59f2b6so54698666b.2
        for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 04:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761218964; x=1761823764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GOi8L/T/sc914HyVaQllPfco9t+JbsWkC8LrVlAzwL4=;
        b=jwfrK8thrXGCV32G7zBks/av8cvyhCoRbtv3JTkDdZhEPt52F4IpIya/eGIwON9ctM
         /Airg0vaU/J91SbREOgRSl7MVthJ0IaCE3NUBNZdKAdll0PlmWFP2du2Z6G7KbsbZshl
         dbglUBF3Ig9Ov5dTFoDaUxtkexpiI4GehnvUXhwGpbxzEZtI6DdTAwRtSWZjWoWxrm1A
         OTltS2GZKmpn5MAsWUTOaBdpEIEKeamRdfcNf3iMBcwSsHAcsTAp7Tq3ueHVAheloz3q
         8nXLsR/CYENHvn4WXOJh1DKsmaw7egVewLb7JAmaEWNOid6Yg1r7iRshB4iIb5InZAuR
         +BwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761218964; x=1761823764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GOi8L/T/sc914HyVaQllPfco9t+JbsWkC8LrVlAzwL4=;
        b=PKFSOCnjFywKc0FdQo8Ei6CUfjFFPgd56ZrxfRX0l2kMeIF91AcJPAq5t5JjgjR83J
         G0hHgCj/aviRm3LY+tAgyMVgoc0lOfI/KuHwGa1kcBKBXHNBclCvXb29qEt0vS9/4D7n
         EBTlk0z3nkU7Hu/MGEyLGog3elqGi48keFsj8SM0+U2VumYgfS5GjE6xq/mT7BR8ei7T
         VT4Ebl0/OyqObFvPeTfTxQWVNH6NVtHzZqIL6rvgpcuWQEHdyQSMAO6c83uZI75ykoAO
         bgmXlLf+nxtkudanvsW1TjDIFrFre5tIlK9M5oSw+vXsHLaZTFrrdluYUP5Epbxb7Fcu
         x9RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcWfnPVA+l31BeWJYAjbTYVFSqFTNLiOfgfFn2OBVJessY9SeX+A6QeCj6ccKcuRqFno9oqVzY/VTSYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuTpNHdmykQ1SgRzzKAI1unLH+0Ao84urJQ07J7ee0u1iKDpPH
	5e2M6oTK4k3jcqTwSnbgVnQXqb2Ek6fw1nJSbO/NXeh/aSovpskB/lHtRh/XABkj
X-Gm-Gg: ASbGncvaKQXilO+x8x9yFVMgqcGif3HpQP5Xv9uD092laV6ixP17WTcQlqFVxO+5MWE
	Qwv7BW6utnJmbpuP5ePr7MnD76ZyyUUjvyyFwbNJ6KnKpyvqr/eDBJ7LaO77ZR3Swah4NCIQcM+
	tiwbSiUh/V+dwcdbIupweY94LfxenVz2FsZ09M1Tj+9ba5bbtIkKrKb645p1cmtf2Pwrk6fDskc
	sNf8hSQ3niES08wkhIjQYdn6OizpQaxEb5abBafZzvTI+3JH+IDZDd8aCghJ9w4smciN10QY3eD
	pH40EgUGMUSq94fes2y/JUqEad07SXzOvXpxcpp+hqkgdKXz147R8KVkwcXo1dOZ5qS6gALP0EC
	aAaD3FEFPRsr11GMNNNi+89GLXTbsom6DQrmPIhkPBgv+zO1/nueZ6CJ457/vx7tPsmBYc5+PWo
	7r
X-Google-Smtp-Source: AGHT+IGVcD+OUFGiPRHpX8Zf9AyspMjR70F5rNVEqM4+m7vN8XE7B3HIHBPjz9kYyXDPcdhsgkufaQ==
X-Received: by 2002:a17:907:1b06:b0:b6d:2f3f:3f98 with SMTP id a640c23a62f3a-b6d2f3f4014mr685674566b.41.1761218963986;
        Thu, 23 Oct 2025 04:29:23 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6d51471ef6sm182393366b.72.2025.10.23.04.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 04:29:23 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-lvm@lists.linux.dev,
	lvm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	"DellClientKernel" <Dell.Client.Kernel@dell.com>,
	dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org
Cc: Nhat Pham <nphamcs@gmail.com>,
	Kairui Song <ryncsn@gmail.com>,
	Pavel Machek <pavel@ucw.cz>,
	=?UTF-8?q?Rodolfo=20Garc=C3=ADa=20Pe=C3=B1as=20=28kix=29?= <kix@kix.es>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	"Lennart Poettering" <mzxreary@0pointer.de>,
	Christian Brauner <brauner@kernel.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>
Subject: dm bug: hibernate to swap located on dm-integrity doesn't work (how to get data redundancy for swap?)
Date: Thu, 23 Oct 2025 14:29:13 +0300
Message-ID: <20251023112920.133897-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi.

Hibernate to swap located on dm-integrity doesn't work.
Let me first describe why I need this, then I will describe a bug with steps to reproduce
(and some speculation on cause of the bug).

I want a personal Linux laptop fully protected from data corruption (cosmic rays, etc).
And even if data corruption does happen, I want reliable indication of that,
so that I know that I need to restore from backups and replace faulty hardware.

So I did this:
- I bought a laptop with ECC memory: Dell Precision 7780. It seems to be one of
the few laptop models in the world with ECC memory. And probably the only model
in the world, which DOES HAVE ECC memory, but DOES NOT HAVE nvidia card
- I set up btrfs raid-1

So far, so good. I'm protected from both memory errors and disk errors.

But my swap partition stays unprotected. And yes, I need swap. I have 64 GiB of RAM,
but this still is not enough for zillions of Chromium tabs and vscode windows.

And, according to btrfs docs, if I put swapfile to btrfs, it will be exempt from raid-1 guarantees.

It seems that the only solution in this case is to put swap partition on top of dm-integrity.

Note: I don't need error correcting code for my swap. I don't need a self-healing swap.
The only thing I need is reliable error detection.

There is discussion on Stack Exchange on exactly the same problem:
https://unix.stackexchange.com/questions/269098/silent-disk-errors-and-reliability-of-linux-swap .
I think it reached the same conclusion: the only solution is dm-integrity.

Also, as well as I understand, md raid is not a solution: when reading, it reads
from one disk only, and thus doesn't detect all errors. It can detect remaining errors
during scrub, which is too late (wrong data may be already consumed by some app).

Also: I don't need encryption.

(Also: there is other solution: "cryptsetup --integrity", but it uses dm-integrity anyway. We will
get to it.)

Okay, so I put swap partition to dm-integrity, and it worked!

But then hibernation stopped to work.

And here come steps to reproduce.

Okay, so I have Dell Precision 7780. I bought it year ago, so I don't
think my hardware is faulty. Also, I recently updated BIOS.

My OS is Debian Trixie amd64. My kernel is Linux 6.12.48-1 from Debian.
I created swap partition so:

integritysetup format --integrity xxhash64 /dev/disk/by-partuuid/c4bbc73d-7909-42ea-8d96-eab82512cbe7
integritysetup open --integrity xxhash64 /dev/disk/by-partuuid/c4bbc73d-7909-42ea-8d96-eab82512cbe7 swap
mkswap /dev/mapper/swap
swapon /dev/mapper/swap

When I need to activate swap, I do this:

integritysetup open --integrity xxhash64 /dev/disk/by-partuuid/c4bbc73d-7909-42ea-8d96-eab82512cbe7 swap
swapon /dev/mapper/swap

When I need to hibernate, I do "systemctl hibernate".

And hibernate appears to work.

Then, when I need to resume, I boot to my hand-crafted initramfs.
That initramfs does this (I slightly simplified this script):

==
busybox mount -t proc proc /proc
busybox mount -t devtmpfs devtmpfs /dev
busybox mount -t sysfs sysfs /sys
modprobe nvme
modprobe dm-integrity
modprobe xxhash64
sleep 1
integritysetup open --integrity xxhash64 "$LOWER_SWAP_DEV" early-swap
sleep 1
# The following "blkid" command should detect what is present on /dev/mapper/early-swap
TYPE="$(blkid --match-tag TYPE --output value /dev/mapper/early-swap)"
if [ "$TYPE" = 'swsuspend' ]; then
  echo "got hibernation image, trying to resume"
  echo /dev/mapper/early-swap > /sys/power/resume
elif [ "$TYPE" = 'swap' ]; then
  echo 'got normal swap without hibernation image'
  integritysetup close early-swap
  # proceed with fresh boot here
fi
==

And this doesn't work. Hibernate works, resume doesn't. :)
"blkid" reports swap as "swap" as opposed to "swsuspend".

I suspect this is because hibernation doesn't flush dm-integrity journal.

Also I tried to add "--integrity-bitmap-mode" to "format" and "open".
Resume started to work, but when I try to shutdown resumed system,
I get errors about corrupted dm-integrity partition. (Of course, I
did necessary edits to initramfs script above.)

Also I tried to add "--integrity-no-journal" to "format" and "open".
It didn't work, either. (I don't remember what exactly didn't work.
I can do this experiment again, if needed.)

Then I tried to do "cryptsetup" instead of "integritysetup". I created
swap partition so:

cryptsetup luksFormat --type luks2 /dev/disk/by-partuuid/c4bbc73d-7909-42ea-8d96-eab82512cbe7 /tmp/key
cryptsetup open --type luks2 --key-file /tmp/key /dev/disk/by-partuuid/c4bbc73d-7909-42ea-8d96-eab82512cbe7 swap
mkswap /dev/mapper/swap
swapon /dev/mapper/swap

And, of course, I did all necessary edits to initramfs.

And this time everything worked. This proves that I didn't do any mistakes in my setup
(i. e. I got initramfs right, etc), and this is actual bug in dm-integrity.

Unfortunately, LUKS created such way doesn't have any redundancy. So this is not solution for me.

So I did this:
cryptsetup luksFormat --type luks2 --integrity hmac-sha256 /dev/disk/by-partuuid/c4bbc73d-7909-42ea-8d96-eab82512cbe7 /tmp/key
cryptsetup open --type luks2 --key-file /tmp/key /dev/disk/by-partuuid/c4bbc73d-7909-42ea-8d96-eab82512cbe7 swap
mkswap /dev/mapper/swap
swapon /dev/mapper/swap

And this time everything stopped to work, again. I don't remember what exactly went wrong.
As well as I remember, that "blkid" again returned "swap" instead of "swsuspend".
I can run experiment again, if needed.

The commands above use dm-integrity internally. So we clearly see: if dm-integrity is involved, then hibernation
doesn't work.

Here is a user with exactly same problem:
https://www.reddit.com/r/archlinux/comments/atg18t/hibernation_wipes_swap_and_my_system_hangs_on_boot/ .
I. e. "hibernation doesn't work if swap is on LUKS with integrity protection".

So, please, fix this bug. Or say me how to solve my original problem (i. e. achieving full reliable error
reporting). I'm available for testing. Send me experimental patches. I can provide more info, if needed.

There is yet another potential solution: uswsusp ( https://docs.kernel.org/power/userland-swsusp.html ).
In short, this is hibernation driven from userspace. I. e. uswsusp allows for finer control of hibernation.
Thus, I can write my own userspace util, which will do hibernation, and execute "integritysetup close"
after writing image. Assuming that original problem is what I think (i. e. lack of journal flush after writing of image),
this may work. The problem is... latest commit to userspace implementation is dated 2012-09-15
( https://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-utils.git/ ). Do I really need to use such ancient
technology? I didn't test this yet, I will test it in coming days. Even if it works, this will still mean that dm-integrity
is buggy with kernel-based hibernation.

-- 
Askar Safin
