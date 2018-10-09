Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL 00/45] lightnvm updates for 4.20.
To: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181009111215.7653-1-mb@lightnvm.io>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d16b0748-5771-6743-4ddf-0d974309a3b2@kernel.dk>
Date: Tue, 9 Oct 2018 08:25:46 -0600
MIME-Version: 1.0
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/9/18 5:11 AM, Matias Bjørling wrote:
> Hi Jens,
> 
> Please pick up the following patches for 4.20.
> 
> The changes include:
> 
>  - pblk trace support from Hans.
>  - SPDX license header update from Javier.
>  - Tons of refactoring patches from Javier, and me to cleanly abstract
>    the 1.2 and 2.0 specs behind a common core interface.
>  - Enable pblk to use a common interface to retrieve chunk metadata.
>    From me.
>  - Bug fixes from Hans, Javier, Jia-ju, Wei, Zhoujie, and me.

Applied, thanks Matias.

-- 
Jens Axboe
