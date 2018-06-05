Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
References: <11b01169-8e11-34ed-8137-aa5cd50a39c2@kernel.dk>
 <CA+55aFy6_+90WKyDAbhh0NcN22N11AyaCaJu0nrafmf49+h6tQ@mail.gmail.com>
 <52aaf207-ef5d-a886-66fe-566de9d9bbee@kernel.dk> <CA+55aFz_iLabbCcCEWY8j5KcKCDsC7074f4EDi8mxB7-FrBHwA@mail.gmail.com>
 <20180604182017.GA1351649@devbig577.frc2.facebook.com> <CA+55aFwOjtyPODy2U9vBQjxjXYq=veRzvMS2Uwdt8f1erRXe1A@mail.gmail.com>
 <f35436ab-bdac-5277-d0d2-b8432c620aff@kernel.dk> <20180604190428.GA30325@kmo-pixel>
 <CA+55aFyv5v7S_Qj0WwxE0foK69p+WVeDrq1ZKD9EJfP20sJboQ@mail.gmail.com>
In-Reply-To: <CA+55aFyv5v7S_Qj0WwxE0foK69p+WVeDrq1ZKD9EJfP20sJboQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 4 Jun 2018 17:44:37 -0700
Message-ID: <CA+55aFyN+qt-bkkmO9H0=yqogAtCdd7KqF2BhX4xgrov_td3Ug@mail.gmail.com>
Subject: Re: [GIT PULL] Block changes for 4.18-rc
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	linux-block <linux-block@vger.kernel.org>, NeilBrown <neilb@suse.com>,
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 4, 2018 at 5:42 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> How about just the attached?

Note: it probably goes without saying that the patch was entirely
untested, but it does build, and it does get rid of the insane stack
use.

                Linus
