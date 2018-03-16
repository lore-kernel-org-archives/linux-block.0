Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] block: sed-opal: fix u64 short atom length
To: Scott Bauer <scott.bauer@intel.com>
Cc: Jonathan Derrick <jonathan.derrick@intel.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
References: <1520379912.4178.83.camel@intel.com>
 <20180301132700.1279-1-jonas.rabenstein@studium.uni-erlangen.de>
 <20180307165556.2618-1-jonas.rabenstein@studium.uni-erlangen.de>
 <20180316153808.bwhyhwxgne7oqtoh@sbauer-Z170X-UD5>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <27d404ea-6aa1-6347-fc8d-a8fade43aae8@kernel.dk>
Date: Fri, 16 Mar 2018 09:14:51 -0700
MIME-Version: 1.0
In-Reply-To: <20180316153808.bwhyhwxgne7oqtoh@sbauer-Z170X-UD5>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/16/18 8:38 AM, Scott Bauer wrote:
> On Wed, Mar 07, 2018 at 05:55:56PM +0100, Jonas Rabenstein wrote:
>> The length must be given as bytes and not as 4 bit tuples.
>>
>> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
>> ---
>> v2:
>>   - use fls64
>>   - shorten loop body
>> ---
>>  block/sed-opal.c | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> Reviewed-by: Scott Bauer <scott.bauer@intel.com>
> Tested-by: Scott Bauer <scott.bauer@intel.com>
> 
> Hi Jens,
> 
> When you get time can you apply this if you have no objections?

Done.

-- 
Jens Axboe
