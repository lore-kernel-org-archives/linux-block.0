Subject: Re: Final opal patches for rc1
To: Scott Bauer <scott.bauer@intel.com>, linux-block@vger.kernel.org
References: <1487783708-16285-1-git-send-email-scott.bauer@intel.com>
Cc: keith.busch@intel.com, linux-nvme@lists.infradead.org, hch@lst.de,
 jonathan.derrick@intel.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <8f4f0a3a-be80-8704-0168-c74d4dbe4feb@fb.com>
Date: Thu, 23 Feb 2017 11:57:02 -0700
MIME-Version: 1.0
In-Reply-To: <1487783708-16285-1-git-send-email-scott.bauer@intel.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/22/2017 10:15 AM, Scott Bauer wrote:
> These are the final changes for rc1.
> 
> Patch 1 contains some code to clean up an opal structure if something changes
> at runtime. (already reviewed by Christoph)
> 
> Patch 2 contains changes to the nvme driver to use the above patch. If a new
> FW is loaded and we no longer support opal we clean up. This patch is based off
> code from Keith and Christoph.
> 
> Patch 3 is a one line change to propagate an original error messaage to user
> land instead of the return status of the session termination code.

Applied, thanks.

-- 
Jens Axboe
