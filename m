Return-Path: <whitebox@nefkom.net>
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,  Martin Steigerwald <martin@lichtvoll.de>,  Jens Axboe <axboe@kernel.dk>,  jdow <jdow@earthlink.net>,  linux-m68k <linux-m68k@lists.linux-m68k.org>,  linux-block@vger.kernel.org
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for disks >= 2 TB
References: <20180627012421.80B8F24E094@nmr-admin>
	<b39c2bf0-de19-ef6e-75bf-b9fae33255c6@gmail.com>
	<CAMuHMdVtvv1Cxxuf__TUKGUJiuTUohGx5XvY_3nQ7vD5J_BBAw@mail.gmail.com>
	<3681004.ZGfTzPZDUK@merkaba>
	<CAMuHMdXqzQFTNjWrRrgUrEO5XVy+X_ztnnCEZo3vYXVCJp4n8w@mail.gmail.com>
	<102c5f41-7fa8-267c-973a-176d3c3d4f57@gmail.com>
Date: Fri, 29 Jun 2018 14:44:00 +0200
In-Reply-To: <102c5f41-7fa8-267c-973a-176d3c3d4f57@gmail.com> (Michael
	Schmitz's message of "Fri, 29 Jun 2018 20:42:54 +1200")
Message-ID: <87po09bw4v.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

On Jun 29 2018, Michael Schmitz <schmitzmic@gmail.com> wrote:

> Would MSDOS recognize the GPT partition as 'probably FAT', and attempt
> to use it?

GPT has the concept of a protective MBR which should prevent such errors.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
