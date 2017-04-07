Subject: Re: [PATCH] block: sed-opal: Tone down all the pr_* to debugs
To: Scott Bauer <scott.bauer@intel.com>, linux-block@vger.kernel.org
References: <1491581217-7342-1-git-send-email-scott.bauer@intel.com>
Cc: jonathan.derrick@intel.com, hch@lst.de
From: Jens Axboe <axboe@fb.com>
Message-ID: <ade6269d-e53f-a983-c09c-3def38472be7@fb.com>
Date: Fri, 7 Apr 2017 12:08:21 -0600
MIME-Version: 1.0
In-Reply-To: <1491581217-7342-1-git-send-email-scott.bauer@intel.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/07/2017 10:06 AM, Scott Bauer wrote:
> Lets not flood the kernel log with messages unless
> the user requests so.

Can you send this against my for-4.12/block of for-next branch? One
hunk is rejected right now, looks like this is against master.

-- 
Jens Axboe
