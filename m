Subject: Re: [PATCH v4 0/6] blk-mq: generalization and bug fixes for tag
 allocation
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
References: <cover.1474100040.git.osandov@fb.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com,
 Alexei Starovoitov <ast@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <54286aca-7ce6-5138-9189-83a2dff444b1@fb.com>
Date: Sat, 17 Sep 2016 08:42:06 -0600
MIME-Version: 1.0
In-Reply-To: <cover.1474100040.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/17/2016 02:28 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>
> This is v4 of the patch series to turn blk-mq's scalable tag allocation
> into a generic library, fixing a few bugs along the way. This is both
> cleanup and preparation for coming blk-mq work.

Thanks Omar, applied for 4.9.

-- 
Jens Axboe
