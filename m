Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
References: <11b01169-8e11-34ed-8137-aa5cd50a39c2@kernel.dk>
 <CA+55aFy6_+90WKyDAbhh0NcN22N11AyaCaJu0nrafmf49+h6tQ@mail.gmail.com>
 <52aaf207-ef5d-a886-66fe-566de9d9bbee@kernel.dk> <CA+55aFz_iLabbCcCEWY8j5KcKCDsC7074f4EDi8mxB7-FrBHwA@mail.gmail.com>
 <20180604182017.GA1351649@devbig577.frc2.facebook.com>
In-Reply-To: <20180604182017.GA1351649@devbig577.frc2.facebook.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 4 Jun 2018 11:22:27 -0700
Message-ID: <CA+55aFwOjtyPODy2U9vBQjxjXYq=veRzvMS2Uwdt8f1erRXe1A@mail.gmail.com>
Subject: Re: [GIT PULL] Block changes for 4.18-rc
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Kent Overstreet <kent.overstreet@gmail.com>,
	linux-block <linux-block@vger.kernel.org>, NeilBrown <neilb@suse.com>,
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 4, 2018 at 11:20 AM Tejun Heo <tj@kernel.org> wrote:
>
>
> Looking at the code, the fundamental problem seems to be that it's
> weaving different parts of sync and async paths.  I don't understand
> why it'd punt the destructin of mddev but destroy biosets
> synchronously.  Can't it do sth like the following?

Yeah, that looks like the right thing to do.

Jens/Kent?

             Linus
