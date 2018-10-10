Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: remove redundant 'default n' from Kconfig-s
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20181009143255eucas1p2fa83e06a951634e4359b4492d54ec7cb@eucas1p2.samsung.com>
 <20181009143255eucas1p2fa83e06a951634e4359b4492d54ec7cb~b90V1TQEm3273032730eucas1p2h@eucas1p2.samsung.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <99a2b013-c380-b0f8-0ed1-a760b925120f@kernel.dk>
Date: Wed, 10 Oct 2018 14:11:54 -0600
MIME-Version: 1.0
In-Reply-To: <20181009143255eucas1p2fa83e06a951634e4359b4492d54ec7cb~b90V1TQEm3273032730eucas1p2h@eucas1p2.samsung.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/9/18 8:32 AM, Bartlomiej Zolnierkiewicz wrote:
> 'default n' is the default value for any bool or tristate Kconfig
> setting so there is no need to write it explicitly.
> 
> Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
> is not set' for visible symbols") the Kconfig behavior is the same
> regardless of 'default n' being present or not:
> 
>     ...
>     One side effect of (and the main motivation for) this change is making
>     the following two definitions behave exactly the same:
>     
>         config FOO
>                 bool
>     
>         config FOO
>                 bool
>                 default n
>     
>     With this change, neither of these will generate a
>     '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
>     That might make it clearer to people that a bare 'default n' is
>     redundant.
>     ...

Applied, thanks.

-- 
Jens Axboe
