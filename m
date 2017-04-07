Subject: Re: [RESEND PATCH] block: sed-opal: Tone down all the pr_* to debugs
To: Scott Bauer <scott.bauer@intel.com>, linux-block@vger.kernel.org
References: <1491595130-5837-1-git-send-email-scott.bauer@intel.com>
Cc: jonathan.derrick@intel.com, hch@lst.de
From: Jens Axboe <axboe@fb.com>
Message-ID: <41380753-3ee1-2a80-6704-9c9dcdcda03a@fb.com>
Date: Fri, 7 Apr 2017 14:24:41 -0600
MIME-Version: 1.0
In-Reply-To: <1491595130-5837-1-git-send-email-scott.bauer@intel.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/07/2017 01:58 PM, Scott Bauer wrote:
> Lets not flood the kernel log with messages unless
> the user requests so.

Thanks Scott, applied for 4.12.

-- 
Jens Axboe
